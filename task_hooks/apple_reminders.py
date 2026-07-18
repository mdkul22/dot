#!/usr/bin/env python3
"""Synchronize Taskwarrior changes to Apple Reminders."""

import json
import os
import subprocess
import sys
from datetime import datetime, timezone


REMINDERS_LIST = os.environ.get("TASK_REMINDERS_LIST", "Projects")
REMINDERS_CLI = os.environ.get("TASK_REMINDERS_CLI", "rem")
REMINDER_ID_FIELD = "apple_reminder_id"


def run_rem(*arguments):
    environment = os.environ.copy()
    environment["NO_COLOR"] = "1"
    result = subprocess.run(
        [REMINDERS_CLI, *arguments],
        check=False,
        capture_output=True,
        env=environment,
        text=True,
    )
    if result.returncode != 0:
        detail = result.stderr.strip() or result.stdout.strip() or "unknown error"
        raise RuntimeError(detail)
    return result.stdout.strip()


def reminder_due(task):
    value = task.get("due")
    if not value:
        return None

    due_utc = datetime.strptime(value, "%Y%m%dT%H%M%SZ").replace(
        tzinfo=timezone.utc
    )
    return due_utc.astimezone().strftime("%Y-%m-%d %H:%M")


def reminder_priority(task):
    return {
        "H": "high",
        "M": "medium",
        "L": "low",
    }.get(task.get("priority"), "none")


def reminder_notes(task):
    lines = [f"Taskwarrior UUID: {task.get('uuid', '')}"]

    if task.get("project"):
        lines.append(f"Project: {task['project']}")

    annotations = [
        item.get("description", "")
        for item in task.get("annotations", [])
        if item.get("description")
    ]
    if annotations:
        lines.extend(["", "Annotations:", *annotations])

    return "\n".join(lines)


def create_reminder(task):
    arguments = [
        "add",
        task["description"],
        "--list",
        REMINDERS_LIST,
        "--priority",
        reminder_priority(task),
        "--notes",
        reminder_notes(task),
        "--output",
        "json",
    ]

    due = reminder_due(task)
    if due:
        arguments.extend(["--due", due])

    tags = task.get("tags", [])
    if tags:
        arguments.extend(["--tags", ",".join(tags)])

    response = json.loads(run_rem(*arguments))
    reminder_id = response.get("id") or response.get("ID")
    if not reminder_id:
        raise RuntimeError("rem did not return a reminder ID")

    task[REMINDER_ID_FIELD] = reminder_id
    return f"created reminder in {REMINDERS_LIST}"


def update_reminder(old, new, reminder_id):
    arguments = ["update", reminder_id]

    if old.get("description") != new.get("description"):
        arguments.extend(["--title", new["description"]])

    if old.get("due") != new.get("due"):
        arguments.extend(["--due", reminder_due(new) or "none"])

    if old.get("priority") != new.get("priority"):
        arguments.extend(["--priority", reminder_priority(new)])

    notes_fields = ("project", "annotations")
    if any(old.get(field) != new.get(field) for field in notes_fields):
        arguments.extend(["--notes", reminder_notes(new)])

    old_tags = set(old.get("tags", []))
    new_tags = set(new.get("tags", []))
    added_tags = sorted(new_tags - old_tags)
    removed_tags = sorted(old_tags - new_tags)
    if added_tags:
        arguments.extend(["--add-tags", ",".join(added_tags)])
    if removed_tags:
        arguments.extend(["--remove-tags", ",".join(removed_tags)])

    if len(arguments) == 2:
        return None

    run_rem(*arguments)
    return "updated reminder"


def synchronize_add(task):
    if task.get("status") not in {"completed", "deleted"}:
        return create_reminder(task)
    return None


def synchronize_modify(old, new):
    reminder_id = new.get(REMINDER_ID_FIELD) or old.get(REMINDER_ID_FIELD)
    status = new.get("status")

    if not reminder_id:
        if status not in {"completed", "deleted"}:
            return create_reminder(new)
        return None

    new[REMINDER_ID_FIELD] = reminder_id

    if status == "deleted" and old.get("status") != "deleted":
        run_rem("delete", reminder_id, "--force")
        return "deleted reminder"

    if status == "completed" and old.get("status") != "completed":
        run_rem("complete", reminder_id)
        return "completed reminder"

    if old.get("status") == "completed" and status != "completed":
        run_rem("uncomplete", reminder_id)

    return update_reminder(old, new, reminder_id) or (
        "reopened reminder" if old.get("status") == "completed" else None
    )


def main():
    input_lines = [line for line in sys.stdin if line.strip()]
    message = None

    if len(input_lines) == 1:
        task = json.loads(input_lines[0])
        try:
            message = synchronize_add(task)
        except Exception as error:
            message = f"sync failed: {error}"
    elif len(input_lines) == 2:
        old = json.loads(input_lines[0])
        task = json.loads(input_lines[1])
        try:
            message = synchronize_modify(old, task)
        except Exception as error:
            message = f"sync failed: {error}"
    else:
        raise RuntimeError("expected one or two Taskwarrior JSON records")

    print(json.dumps(task, separators=(",", ":")))
    if message:
        print(f"Apple Reminders: {message}")


if __name__ == "__main__":
    main()
