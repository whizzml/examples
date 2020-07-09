#!/bin/bash

source ../../test-utils.sh

rm -f -R cmd_del
rm -f -R cmd
rm -f -R .build

# Finds the resource id for the name variable in WhizzML output
function whizzml_output(){
  path=$1
  name=$2

  outputs=$(cat "$path/whizzml_results.txt" | sed -n -e '/outputs/,/\]\]/p')
  echo "$outputs" | grep -A1 "$name" | tail -n1 | cut -d"'" -f2 
}

function make_input(){
  test_dsid=$1

  cat -- <<EOF 
[["ds-id", "$test_dsid"], ["objective-field", "000008"], 
["training-rate", 0.8]]
EOF
}

function check_result(){
  path=$1
  true_count=$2
  false_count=$3
 
  dsid=$(whizzml_output "$path" "training-ds")

  run_bigmler sample --dataset "$dsid" --mode linear --row-fields "diabetes" --output-dir "$path"

  true_check=$(cat "$path/sample.csv" | grep 'true' | wc -l | tr -d ' ')
  false_check=$(cat "$path/sample.csv" | grep 'false' | wc -l | tr -d ' ')

  if [ "$true_check" != "$true_count" ]; then
    echo "stratified split KO: in $path expected true_count=$true_count but got $true_check"
    exit 1
  else
    log "    ok true_count: $true_count == $true_check"
  fi

  if [ "$false_check" != "$false_count" ]; then
    echo "stratified split KO: in $path expected false_count=$false_count but got $false_check"
  else
    log "    ok false_count: $false_count == $false_check"
  fi
}

function run_test(){
  test_dsid=$1
  true_check=$2
  false_check=$3

  last_run=$(ls -ld cmd/result* 2>/dev/null | cut -d'/' -f2 | tr -d '[a-z]' | sort -n | tail -n1)

  if [ -z "$last_run" ]; then
    run=1
  else
    run=$[${last_run}+1]
  fi

  # building the inputs for the test
  make_input $test_dsid > "test${run}_inputs.json"

  log "Test${run} $*"

  # running the execution with the given inputs
  run_bigmler execute --scripts .build/scripts --inputs "test${run}_inputs.json" \
                      --output-dir cmd/result${run}

  check_result "cmd/result${run}" $true_check $false_check
}

log "-------------------------------------------------------"
log "Test for stratified-sampling package"
log "-------------------------------------------------------"

log "Creating the whizzml script..."
run_bigmler whizzml --package-dir ../ --output-dir ./.build

log "Creating diabetes CSV from s3..."
run_bigmler --train s3://bigml-public/csv/diabetes.csv --no-model \
            --project "Whizzml examples tests" \
            --output-dir cmd/pre_test

test_dsid=$(cat cmd/pre_test/dataset)


run_test $test_dsid 214 400

# remove the created resources
run_bigmler delete --from-dir cmd --output-dir cmd_del
run_bigmler delete --from-dir .build --output-dir cmd_del
rm -f -R test*_inputs.json cmd cmd_del
rm -f -R .build .bigmler*

log "stratified-split OK"
