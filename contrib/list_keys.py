#!/usr/bin/python3
import sys
import os
import re
import argparse

def find_keys(prefix, fn):
    with open(fn) as fd:
        text = fd.read()
    for match in re.findall(r"\\drefset{([^}]*)}{([^}]*)}", text):
        yield (prefix+match[0], match[1])

    for match in re.finditer(r"\\drefinput(?:\[(?P<key_prefix>[^\])]*)\])?{(?P<file>[^}]*)}", text):
        key_prefix, fn2 = match.groups()
        key_prefix = key_prefix or ""
        fn2 = os.path.join(os.path.dirname(fn), fn2)
        for ext in ("", ".tex", ".sty"):
            if os.path.exists(fn2 + ext):
                for x in find_keys(prefix + key_prefix, fn2 + ext):
                    yield x
                break

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Find and list dref keys.')
    parser.add_argument('files', metavar='FILE', nargs='+',
                        help='Files to find the keys')
    parser.add_argument('--emacs', action='store_true',
                        help='produce SEXPs instead of list')

    args = parser.parse_args()

    if args.emacs:
        print("(")

    for fn in args.files:
        keys = find_keys("", fn)
        for k, v in keys:
            if args.emacs:
                print("(\"{}\" . \"{}\")".format(repr(k)[1:-1], repr(v)[1:-1]))
            else:
                print(k,'\t',v)

    if args.emacs:
        print(")")
