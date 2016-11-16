#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for anomaly-benchmarking package"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data --no-model \
            --project "Whizzml examples tests" --output-dir cmd/pre_test

# building the inputs for the first test
prefix='[["dataset-list", ["'
suffix='"]], ["replicates", 1]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
done
log "Testing generate-datasets script (one replicate)  -------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/generate-datasets/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"generated-datasets\", "
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "one replicate OK"
    else
        echo "one replicate KO:\n $file_content"
        exit 1
fi

# building the inputs for the second test
prefix='[["dataset-list", ["'
suffix='"]], ["diff-map", {"easy": 0.1333333}], ["freq-list", [0.001]]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
done
log "Testing generate-datasets script (ten replicates)  -------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/generate-datasets/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"generated-datasets\", "
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "ten replicates OK"
    else
        echo "ten replicates KO:\n $file_content"
        exit 1
fi
# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
