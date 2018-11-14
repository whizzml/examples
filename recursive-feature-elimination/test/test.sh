#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for recursive feature elimination script"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train s3://bigml-public/csv/diabetes.csv --no-model \
            --project "Whizzml examples tests" --output-dir cmd/pre_test
# building the inputs for the test 1
prefix1='[["dataset-id", "'
suffix1='"],'
prefix2='["test-dataset-id", "'
suffix2='"], ["n", 2], ["evaluation-metric", "average_phi"]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix1$dataset$suffix1$prefix2$dataset$suffix2" > "test_inputs.json"
done
log "Testing RFE with test-dataset-id ----------------------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"output-features\", .*\[\"output-dataset\""
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "RFE with test-dataset-id OK"
    else
        echo "RFE with test-dataset-id KO:\n $file_content"
        exit 1
fi
# remove the created resources
rm -f -R test_inputs.json 


# building the inputs for the test 2
prefix1='[["dataset-id", "'
suffix1='"],["n", 2], ["test-dataset-id", ""], ["evaluation-metric", "average_phi"]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix1$dataset$suffix1" > "test_inputs.json"
done
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"output-features\", .*\[\"output-dataset\""
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "RFE without test-dataset-id OK"
    else
        echo "RFE without test-dataset-id KO:\n $file_content"
        exit 1
fi
# remove the created resources
rm -f -R test_inputs.json

# building the inputs for the test 3
prefix1='[["dataset-id", "'
suffix1='"],'
prefix2='["test-dataset-id", "'
suffix2='"], ["n", 2], ["evaluation-metric", ""]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix1$dataset$suffix1$prefix2$dataset$suffix2" > "test_inputs.json"
done
log "Testing RFE with test-dataset-id (without metric) -------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"output-features\", .*\[\"output-dataset\""
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "RFE with test-dataset-id (without metric) OK"
    else
        echo "RFE with test-dataset-id (without metric) KO:\n $file_content"
        exit 1
fi



# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*

