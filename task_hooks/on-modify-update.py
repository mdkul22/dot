#!/usr/bin/env python3
import sys
import json
import time
import os


def main():

    otask = json.loads(sys.stdin.readline())
    mtask = json.loads(sys.stdin.readline())

    if 'update' in mtask.keys():
        old_content = ''
        timestamp = os.getenv('TEST_TIME') or time.strftime("%y:%m:%d %H:%M:%S: ")
        if 'update' in otask.keys():
            if otask['update'] == mtask['update']:
                print(json.dumps(mtask))
            else:
                old_content = otask['update'] + '\n'
                # Prepend a timestamp to the new update entry. The previous
                # implementation incorrectly swapped the month and minute
                # fields, producing output such as `25:48:26` for July 26th at
                # 00:48. Use the correct format of `YY:MM:DD HH:MM:SS:`.
                mtask['update'] = (
                    old_content
                    + time.strftime("%y:%m:%d %H:%M:%S: ")
                    + mtask['update']
                )
                print(json.dumps(mtask))
        else:
            mtask['update'] = timestamp + mtask['update']
            print(json.dumps(mtask))
    else:
        print(json.dumps(mtask))
    sys.exit(0)


if __name__ == "__main__":
    main()

