#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for name-clusters script"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler cluster --train whiskies_labeled.csv\
            --k 4\
            --cluster-models "Cluster 1,Cluster 2"\
            --project "Whizzml examples tests" --output-dir cmd/pre_test



# building the inputs for the test 1
prefix1='[["cluster-id", "'
suffix1='"],'
prefix2='["number-of-terms", 2], ["separator", ","]]'
text=''
cat cmd/pre_test/clusters | while read dataset
do
echo "$prefix1$dataset$suffix1$prefix2" > "test_inputs.json"
done
log "Testing name-clusters with all the data ----------------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"result\", \[\{\"name\": \"Spicy = Low,Sweetness = Medium\"\},"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "name-clusters test with default data OK"
    else
        echo "name-clusters test with default data KO:\n $file_content"
        exit 1
fi

## remove the created resources
rm -f -R test_inputs.json 


# building the inputs for the test 2
prefix1='[["cluster-id", "'
suffix1='"],'
prefix2='["number-of-terms", 2], ["separator", "-"]]'
text=''
cat cmd/pre_test/clusters | while read dataset
do
echo "$prefix1$dataset$suffix1$prefix2" > "test_inputs.json"
done
log "Testing name-clusters with separator - -------------- ------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"result\", \[\{\"name\": \"Spicy = Low-Sweetness = Medium\"\},"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "name-clusters test with different separator  OK"
    else
        echo "name-clusters test with different separator KO:\n $file_content"
        exit 1
fi

# remove the created resources
rm -f -R test_inputs.json
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*

