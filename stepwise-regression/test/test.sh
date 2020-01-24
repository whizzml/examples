#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for stepwise regression script"
log "Creating test inputs"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train s3://bigml-public/csv/iris.csv --no-model \
            --project "Whizzml examples tests" --output-dir cmd/pre_test
# building the inputs for the test
prefix='[["dataset-id", "'
suffix='"], ["threshold", 0.05], ["objective-id", "000004"]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
done
log "Testing stepwise regression script"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"results\": \[\[\"petal length\", \"petal width\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "stepwise regression OK"
    else
        echo "stepwise regression KO:\n $file_content"
        exit 1
fi
# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
