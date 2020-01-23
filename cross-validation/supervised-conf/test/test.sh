#!/bin/bash

source ../../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for cross-validation"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train s3://bigml-public/csv/iris.csv \
            --model-fields "petal length,species" \
            --project "Whizzml examples tests" --output-dir cmd/pre_test

# building the inputs for the test
prefix='[["slm-id", "'
suffix='"],["delete-resources", false]]'
text=''
cat cmd/pre_test/models | while read model
do
echo "$prefix$model$suffix" > "test_inputs.json"
done
log "Testing supervised learning model script --------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts \
                    --inputs test_inputs.json  --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"cross-validation-output\",\
 \"evaluation/[a-f0-9]{24}\", \"evaluation\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "supervised-conf OK"
    else
        echo "supervised-conf KO:\n $file_content"
        exit 1
fi

log "-------------------------------------------------------"
# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
