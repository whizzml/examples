#!/usr/bin/env python

import json
import sys

with open(sys.argv[1], "rb") as fin:
    data = json.load(fin)

if "outputs" not in data:
    exit(1)

output_map = {output[0]: output[1] for output in data['outputs']}

if "repaired-dataset" not in output_map.keys():
    exit(1)
if "processor" not in output_map.keys():
    exit(1)
if "model_map" not in output_map['processor']:
    exit(1)
if not isinstance(output_map['processor']['model_map'], dict):
    exit(1)
if not isinstance(output_map['processor']['excluded_fields'], list):
    exit(1)

models = output_map['processor']['model_map']

for field in models:
    if models[field] != "" and not models[field].startswith("ensemble"):
        exit(1)

exit(0)
