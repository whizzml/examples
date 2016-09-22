#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for Auto-complete Dataset script"
run_bigmler whizzml --package-dir ../ --output-dir ./.build

# creating the resources needed to run the test
run_bigmler --train s3://bigml-public/csv/kaggle_titanic_train.csv --no-model \
            --project "Whizzml examples tests" --output-dir cmd/pre_test

# building the inputs for the test
prefix='[["dataset-id", "'
suffix='"]]'

cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
done
log "Testing Auto-complete Dataset script ----------------------------------"

# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"

# use python script to check output
./check_output.py $file

# report results
if [[ $? -eq 0 ]]
    then
        log "Auto-Complete Dataset OK"
else
    echo "Auto-Complete Dataset KO:"
    cat "$file" | python -m json.tool
    exit 1
fi

# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
