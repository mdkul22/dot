#!/usr/bin/env python3
import sys
import json
import time


def main():

    otask = json.loads(sys.stdin.readline())
    mtask = json.loads(sys.stdin.readline())

    if 'update' in mtask.keys():
        old_content = ''
        if 'update' in otask.keys():
            if otask['update'] == mtask['update']:
                print(json.dumps(mtask))
            else:
                old_content = otask['update'] + '\n'
                mtask['update'] = old_content + \
                    time.strftime("%y:%M:%d %H:%m:%S: ") + mtask['update']
                print(json.dumps(mtask))
    else:
        print(json.dumps(mtask))
    sys.exit(0)


if __name__ == "__main__":
    main()

