#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for low-coverage script"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data --no-model \
            --project "Whizzml examples tests" --output-dir cmd/pre_test

# building the inputs for the first test
prefix='[["dataset", "'
suffix='"], ["threshold", 0.1]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
done
log "Testing low-coverage script  -------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts  --inputs test_inputs.json \
                    --output-dir cmd/results

# check the outputs
declare file="cmd/results/whizzml_results.json"

if grep -q "{\"outputs\": \[\[\"filtered-dataset\"" $file
then
  log "low-coverage OK"
else
  echo "KO: low-coverage not set properly in results"
  exit 1
fi

# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
