#!/usr/bin/env python3

# SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

# Perform a deepdiff between two files and pretty print the output
# Deepdiff has a CLI tool called "deep" that does roughly the same thing
# but it doesn't seem to be able to pretty print.

import json, re, sys, pprint
from deepdiff import DeepDiff

with open(sys.argv[1]) as starting_json:
    starting = json.load(starting_json)

with open(sys.argv[2]) as ending_json:
    ending = json.load(ending_json)

ddiff = DeepDiff(starting, ending, ignore_order=True)

pp = pprint.PrettyPrinter(indent=4)

if len(ddiff) > 0:
    print("[FAILED]")
    print("Differences:")
    pp.pprint(ddiff)
    print(ddiff.pretty())
    exit(1)
else:
    print("[PASSED]")