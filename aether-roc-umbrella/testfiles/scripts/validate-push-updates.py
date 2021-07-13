#!/usr/bin/env python

import json, re, sys, pprint
from deepdiff import DeepDiff

if len(sys.argv) != 2:
    print ("Usage: validate-push-updates.py <BASE_FILE_DIR>")
    print ("  - <BASE_FILE_DIR>: base directory of the JSON files validated against pod logs")

base_file_dir = sys.argv[1]

lines = sys.stdin.read()

match = re.findall(r'Push Update endpoint=http://aether-roc-umbrella-sdcore-test-dummy/(\S+) data=(.*?^})', lines, re.DOTALL|re.MULTILINE)

pp = pprint.PrettyPrinter(indent=4)

for (f, j) in match:

    with open("%s/%s" % (base_file_dir, f)) as target_json:
        target = json.load(target_json)

    actual = json.loads(j)

    ddiff = DeepDiff(target, actual, ignore_order=True)

    if len(ddiff) > 0:
        print("[FAILED] %s" % f)
        print("Differences:")
        pp.pprint(ddiff)
        # print(ddiff.pretty())
        print("Exiting...")
        exit(1)
    else:
        print("[PASSED] %s" % f)