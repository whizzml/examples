#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for cross-validation"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train s3://bigml-public/csv/iris.csv --no-model \
            --project "Whizzml examples tests" --output-dir cmd/pre_test

# building the inputs for the test
prefix='[["dataset-id", "'
suffix='"],["model-type", "model"]]'
text=''
prefix_reg='[["objective-id", "000000"],["dataset-id", "'
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
echo "$prefix_reg$dataset$suffix" > "test_reg_inputs.json"
done

log "Testing basic script ----------------------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/basic/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"cross-validation-output\",\
 \"evaluation/[a-f0-9]{24}\", \"evaluation\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "basic OK"
    else
        echo "basic KO:\n $file_content"
fi

log "Testing model script ----------------------------------"
rm cmd/results/whizzml_results.json
# running the execution with the given inputs
run_bigmler execute --scripts .build/model/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"cross-validation-output\",\
 \"evaluation/[a-f0-9]{24}\", \"evaluation\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "model OK"
    else
        echo "model KO:\n $file_content"
        exit 1
fi
log "Testing ensemble script -------------------------------"
rm cmd/results/whizzml_results.json
# running the execution with the given inputs
run_bigmler execute --scripts .build/ensemble/scripts \
                    --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"cross-validation-output\",\
 \"evaluation/[a-f0-9]{24}\", \"evaluation\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "ensemble OK"
    else
        echo "ensemble KO:\n $file_content"
        exit 1
fi
log "Testing logistic regression script --------------------"
rm cmd/results/whizzml_results.json
# running the execution with the given inputs
run_bigmler execute --scripts .build/logistic-regression/scripts \
                    --inputs test_inputs.json  --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"cross-validation-output\",\
 \"evaluation/[a-f0-9]{24}\", \"evaluation\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "logistic regression OK"
    else
        echo "logistic regression KO:\n $file_content"
        exit 1
fi
log "Testing linear regression script --------------------"
rm cmd/results/whizzml_results.json
# running the execution with the given inputs
run_bigmler execute --scripts .build/linear-regression/scripts \
                    --inputs test_reg_inputs.json  --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"cross-validation-output\",\
 \"evaluation/[a-f0-9]{24}\", \"evaluation\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "linear regression OK"
    else
        echo "linear regression KO:\n $file_content"
        exit 1
fi
log "Testing boosted ensemble script -------------------------------"
rm cmd/results/whizzml_results.json
# running the execution with the given inputs
run_bigmler execute --scripts .build/boosted-ensemble/scripts \
                    --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"cross-validation-output\",\
 \"evaluation/[a-f0-9]{24}\", \"evaluation\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "boosted ensemble OK"
    else
        echo "boosted ensemble KO:\n $file_content"
        exit 1
fi
log "Testing deepnet script --------------------"
rm cmd/results/whizzml_results.json
# running the execution with the given inputs
run_bigmler execute --scripts .build/deepnet/scripts \
                    --inputs test_inputs.json  --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"cross-validation-output\",\
 \"evaluation/[a-f0-9]{24}\", \"evaluation\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "deepnet OK"
    else
        echo "deepnet KO:\n $file_content"
        exit 1
fi

log "-------------------------------------------------------"
# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
