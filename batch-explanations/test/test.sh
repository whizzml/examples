#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for batch-explanations"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train s3://bigml-public/csv/iris.csv \
            --project "Whizzml examples tests" --output-dir cmd/pre_test

# building the inputs for the test
prefix='[["dataset-id", "'
infix='"], ["model-id", "'
suffix='"]]'
text=''

paste cmd/pre_test/dataset cmd/pre_test/models | while read dataset model
do
echo "$prefix$dataset$infix$model$suffix" > "test_inputs.json"
done

log "Testing batch explanations script ----------------------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"prediction-list\",\
 \[\"prediction/[a-f0-9]{24}\""
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "basic OK"
    else
        echo "basic KO:\n $file_content"
        exit 1
fi

log "-------------------------------------------------------"
# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
