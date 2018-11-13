#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for k-means minus two"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train s3://bigml-public/csv/diabetes.csv --no-model\
            --project "Whizzml examples tests" --output-dir cmd/pre_test

# building the inputs for the test
prefix='[["dataset", "'
suffix='"], ["k", 5], ["l", 10], ["threshold", 0.95], ["maximum", 5]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
done

log "Testing k-means minus two script ----------------------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"

# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"cluster\", \"cluster/[a-f0-9]{24}\", \"cluster\"\], \[\"dataset-id\", \"dataset/[a-f0-9]{24}\", \"dataset\"\], \[\"anomalies\", \[\[228, 4, 197, 70, 39, 744, 36.7, 2.329, 31, \"false\", \"Cluster 0\", 1.549\]"

declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "k-means minus two OK"
    else
        log "k-means minus two KO:\n $file_content"
fi


log "-------------------------------------------------------"
# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
