#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build1
rm -f -R .build2
rm -f -R .build3

log "-------------------------------------------------------"
log "Test for multi-label script"
run_bigmler whizzml --package-dir ../../items-to-features --output-dir ./.build1
run_bigmler whizzml --package-dir ../create-item-models \
                    --output-dir ./.build2
run_bigmler whizzml --package-dir ../ml-batch-prediction \
                    --output-dir ./.build3

# creating the resources needed to run the test
run_bigmler --train ./multilabel.csv --no-model \
            --source-attributes source.json \
            --project "Whizzml examples tests" --output-dir cmd/pre_test
# building the inputs for the test
prefix='[["dataset", "'
suffix='"], ["objective", "class"], ["model-kind" ,"model"], ["model-parameters", {}]]'
text=''
cat cmd/pre_test/dataset | while read datasets
do
echo "$prefix$datasets$suffix" > "test_inputs.json"
done
log "Testing multi-label script -------------------------------"
# running the execution to create models with the given inputs
run_bigmler execute --scripts .build2/create-item-models/scripts \
                    --inputs test_inputs.json \
                    --output-dir cmd/results --verbosity 1
prefix='[["execution", "'
suffix='"], ["dataset", "'
suffix2='"], ["clean-up?" , true]]'
text=''
cat cmd/results/execution | while read execution
do
cat cmd/pre_test/dataset | while read datasets
do
echo "$prefix$execution$suffix$datasets$suffix2" > "test_inputs.json"
done
done
# running the execution to create models with the given inputs
run_bigmler execute --scripts .build3/ml-batch-prediction/scripts \
                    --inputs test_inputs.json \
                    --output-dir cmd/results --verbosity 1
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\"outputs\": \[\[\"result\", \"dataset\/"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "multi-label OK"
    else
        echo "multi-label KO:\n $file_content"
        exit 1
fi
# remove the created resources
run_bigmler delete --from-dir cmd/pre_test --output-dir cmd_del
run_bigmler delete --from-dir .build1 --output-dir cmd_del
run_bigmler delete --from-dir .build2 --output-dir cmd_del
run_bigmler delete --from-dir .build3 --output-dir cmd_del
cat cmd/results/execution | while read execution
do
run_bigmler delete --id "$execution" --output-dir cmd_del
done
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build* .bigmler*
