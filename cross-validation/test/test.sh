VERBOSITY=${VERBOSITY:-0}
rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build
echo "-------------------------------------------------------"
echo "Test for cross-validation"
bigmler whizzml --package-dir ../ --output-dir ./.build --verbosity $VERBOSITY
# creating the resources needed to run the test
bigmler --train s3://bigml-public/csv/iris.csv --no-model \
        --project "Whizzml examples tests" --output-dir cmd/pre_test \
        --verbosity $VERBOSITY
# building the inputs for the test
prefix='[["dataset-id", "'
suffix='"]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
done
echo "Testing basic script ----------------------------------"
# running the execution with the given inputs
bigmler execute --scripts .build/basic/scripts --inputs test_inputs.json \
                --output-dir cmd/results --verbosity $VERBOSITY
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
echo "Testing model script ----------------------------------"
# running the execution with the given inputs
bigmler execute --scripts .build/model/scripts --inputs test_inputs.json \
                --output-dir cmd/results --verbosity $VERBOSITY
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
fi
echo "Testing ensemble script -------------------------------"
# running the execution with the given inputs
bigmler execute --scripts .build/ensemble/scripts --inputs test_inputs.json \
                --output-dir cmd/results --verbosity $VERBOSITY
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
fi
echo "Testing logistic regression script --------------------"
# running the execution with the given inputs
bigmler execute --scripts .build/logistic-regression/scripts \
                --inputs test_inputs.json \
                --output-dir cmd/results --verbosity $VERBOSITY
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
fi
echo "-------------------------------------------------------"
# remove the created resources
bigmler delete --from-dir cmd --output-dir cmd_del --verbosity $VERBOSITY
bigmler delete --from-dir .build --output-dir cmd_del --verbosity $VERBOSITY
rm -f -R test_inputs.json cmd cmd_del
rm -f -R .build .bigmler*
