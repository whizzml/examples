#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for stacked-predictions script"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train s3://bigml-public/csv/diabetes.csv --no-model \
            --project "Whizzml examples tests" --output-dir cmd/pre_test \
            --test-split 0.5

# building the inputs for the test
prefix='[["training", "'
infix='"], ["holdout", "'
suffix='"]]'
text=''

cat cmd/pre_test/dataset_train | while read train
do
cat cmd/pre_test/dataset_test | while read test
do
echo "$prefix$train$infix$test$suffix" > "test_inputs.json"
done
done

log "Testing stacked-predictions script  -------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"popular-dataset\", "
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "stratified-sampling OK"
    else
        echo "stratified-sampling KO:\n $file_content"
        exit 1
fi

# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
