#!/usr/bin/env bash

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
declare output=$(<$file)
declare dataset="$(echo $output |  jq '.output_resources | .[0] | .id')"
declare code="$(echo $output |  jq '.output_resources | .[0] | .code')"

if [[ "$code " -eq 5 ]] && [[ $dataset == *"dataset"*  ]]
    then
        log "fuzzy-norms OK"
    else
        echo "fuzzy-norms KO:\n $output"
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
