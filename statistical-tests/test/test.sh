#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

log "-------------------------------------------------------"
log "Test for statistical-tests script"
run_bigmler whizzml --package-dir ../ --output-dir ./.build
# creating the resources needed to run the test
run_bigmler --train s3://bigml-public/csv/iris.csv --no-model \
            --project "Whizzml examples tests" --output-dir cmd/pre_test
# building the inputs for the test
prefix='[["dataset-id", "'
suffix='"], ["ad-sample-size", 1024], ["ad-seed", "bigml"]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
done
log "Testing 1-click statistical-tests script ----------------------------"
# running the execution with the given inputs
run_bigmler execute --scripts .build/scripts --inputs test_inputs.json \
                    --output-dir cmd/results
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\[\"summary\", {\"anderson\": {\"p_value\": {\"average\": 0.01068597500028128, \"stdev\": 0.012374359079745692}}, \"benford\": {\"chi_square\": {\"average\": 292.20241500000003, \"stdev\": 190.19936973514876}, \"d_statistic\": {\"average\": 5.663517499999999, \"stdev\": 1.913396191982117}, \"p_value\": {\"average\": 0.0, \"stdev\": 0.0}}, \"grubs\": {\"p_value\": {\"average\": 0.8163882499999999, \"stdev\": 0.3672235}}, \"jarque-bera\": {\"p_value\": {\"average\": 0.0924836765, \"stdev\": 0.12171185657110187}}, \"z-score\": {\"expected_max_z\": {\"average\": 2.71305, \"stdev\": 0.0}, \"max_z\": {\"average\": 2.262595, \"stdev\": 0.6481131575324378}}}, \"map\"\], \[\"tests-results-dataset\", \"dataset/"

declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        log "statistical-tests 1-click OK"
    else
        echo "statistical-tests 1-click KO:\n $file_content"
        exit 1
fi
#remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
