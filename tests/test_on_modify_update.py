import json
import os
import subprocess
import sys
from pathlib import Path

SCRIPT = str(Path(__file__).resolve().parents[1] / "task_hooks" / "on-modify-update.py")

def run_hook(old, new, timestamp="24:01:02 03:04:05: "):
    env = {"TEST_TIME": timestamp}
    proc = subprocess.run(
        [sys.executable, SCRIPT],
        input=f"{json.dumps(old)}\n{json.dumps(new)}\n",
        text=True,
        capture_output=True,
        check=True,
        env={**env, **os.environ},
    )
    return json.loads(proc.stdout)


def test_no_existing_update():
    old = {"update": ""}
    new = {"update": "New entry"}
    output = run_hook(old, new)
    assert output["update"] == "\n24:01:02 03:04:05: New entry"


def test_keep_same_update():
    data = {"update": "same"}
    output = run_hook(data, data)
    assert output == data
