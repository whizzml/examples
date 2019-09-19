#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for batch-association-sets"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler association --train s3://bigml-public/csv/iris.csv \
            --project "Whizzml examples tests" --output-dir cmd/pre_test

# building the inputs for the test
prefix='[["dataset-id", "'
suffix='"],["association-id", "'
suffix2='"],["dataset-name", "batch-assoc-test"]]'
text=''
cat cmd/pre_test/associations | while read associations
do
    cat cmd/pre_test/dataset | while read dataset
    do
      echo "$prefix$dataset$suffix$associations$suffix2" > "test_inputs.json"
    done
done

cat test_inputs.json |while read inputs
do
echo $inputs
done

log "Testing basic script ----------------------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"extended-dataset-id\",\
 \"dataset/[a-f0-9]{24}\""
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "batch-assoc-test OK"
    else
        echo "batch-assoc-test KO:\n $file_content"
fi

log "-------------------------------------------------------"
# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
