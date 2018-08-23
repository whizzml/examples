#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for low-coverage script"
run_bigmler whizzml --package-dir ../ --output-dir ./.build


# building the inputs for the first test
inputs='[["input-dataset-id", "dataset/5b7e97ed00a1e52309000faf"]]'
echo "$inputs" > "test_inputs.json"

log "Testing low-coverage script  -------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts  --inputs test_inputs.json \
                    --output-dir cmd/results


