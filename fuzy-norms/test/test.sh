#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for fuzzy logic norms script"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train logic.csv --no-model \
            --project "Whizzml examples tests" --output-dir cmd/pre_test
# building the inputs for the test

prefix='[["dataset-id", "'

suffix='"], ["field-id1", "field1"], ["field-id2" ,"field2"],
["norms", ["min-tnorm","product","lukasiewicz", "drastic-tnorm",
"nilpotent-min",["schweizer-sklar", 0.5], ["hamacher", 0,5],
["yager",0.5], ["aczel-alsina", 0.5], ["dombi",0.5], ["suge-weber",
0.5], "max-tconorm","probabilistic","bounded", "drastic-tconorm",
"nilpotent-max", "einstein-sum"]]]'

text=''
cat cmd/pre_test/dataset | while read datasets
do
    echo "$prefix$datasets$suffix" > "test_inputs.json"
done

log "Testing fuzzy
logic norms script -------------------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results --verbosity 1
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex='.*output_resources": \[\{"code": 5, "id":'
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "best-first-cv OK"
    else
        echo "best-first-cv KO:\n $file_content"
        exit 1
fi


# remove the created resources
run_bigmler delete --from-dir cmd/pre_test --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
cat cmd/results/execution | while read execution
do
run_bigmler delete --id "$execution" --output-dir cmd_del
done
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
