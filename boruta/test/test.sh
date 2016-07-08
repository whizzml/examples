VERBOSITY=0
rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build
echo "-------------------------------------------------------"
echo "Test for boruta script"
bigmler whizzml --package-dir ../ --output-dir ./.build --verbosity $VERBOSITY
# creating the resources needed to run the test
bigmler --train s3://bigml-public/csv/iris.csv --no-model --project "Whizzml examples tests" --output-dir cmd/pre_test --verbosity $VERBOSITY
# building the inputs for the test
prefix='[["dataset-id", "'
suffix='"], ["objective", "species"], ["min-gain", 0.1]]'
text=''
cat cmd/pre_test/dataset | while read dataset
do
echo "$prefix$dataset$suffix" > "test_inputs.json"
done
echo "Testing boruta script ----------------------------------"
# running the execution with the given inputs
bigmler execute --scripts .build/scripts --inputs test_inputs.json --output-dir cmd/results --verbosity $VERBOSITY
# check the outputs
declare file="cmd/results/whizzml_results.json"
declare regex="\[\[\"importance-output\", \{\"neutral\": \[\"sepal width\", \"sepal length\"\], \"important\": \[\"petal length\", \"petal width\", \"species\"], \"unimportant\": \[\]}, \"map\"\]\]"
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]]
    then
        echo "boruta OK"
    else
        echo "boruta KO:\n $file_content"
fi
# remove the created resources
bigmler delete --from-dir cmd --output-dir cmd_del --verbosity $VERBOSITY
bigmler delete --from-dir .build --output-dir cmd_del --verbosity $VERBOSITY
rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build
