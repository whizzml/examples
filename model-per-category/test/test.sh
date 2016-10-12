#!/bin/bash

source ../../test-utils.sh

outdir=cmd
outdir_del=cmd_del
exec_count=0
last_result=""

function cleanup {
  [ -d $outdir ] && \
      run_bigmler delete --from-dir $outdir --output-dir $outdir_del >/dev/null
  rm -f -R $outdir_del $outdir .bigmler*
}

def_inputs="[\"field\", \"000004\"], [\"objective\", \"000002\"]"
cats_rx="\"categories\": \[(\"Iris-setosa\"|\"Iris-versicolor\"|\"Iris-virginica\"[,\]]+)"

function check_execute_results {
  cnts=$(<$1)
  if [[ $cnts =~ $cats_rx ]]; then
      last_result="$(<$2)"
      log "OK"
  else
      echo "KO: Failed match for categories in $1 with '$cnts'"
      exit 1
  fi
}

function execute_create_models {
  log "Checking model creation..."
  exec_count=$((exec_count+1))
  local inputs=${3:-"[[\"dataset\", \"$2\"], $def_inputs]"}
  local inputs_file="$outdir/create_inputs_$exec_count.json"
  echo $inputs > $inputs_file
  local exec_dir="$outdir/create_$exec_count"
  run_bigmler execute --script $1 \
                      --inputs $inputs_file \
                      --output-dir $exec_dir
  check_execute_results $exec_dir/whizzml_results.json $exec_dir/execution
}

single_rx="\"result\": \"prediction/[a-f0-9]{24}"

function check_single_results {
  last_result=$(<$1)
  if [[ $last_result =~ $single_rx ]]; then
      log "OK"
  else
      echo "KO: Failed single result prediction in $1: $last_result"
      exit 1
  fi
}

function check_single_prediction {
  log "Checking single prediction..."
  exec_count=$((exec_count+1))
  local inputs="[[\"execution\", \"$2\"], [\"input\", $3]]"
  local inputs_file="$outdir/single_inputs_$exec_count.json"
  echo $inputs > $inputs_file
  local exec_dir="$outdir/single_$exec_count"
  run_bigmler execute --script $1 \
                      --inputs $inputs_file \
                      --output-dir $exec_dir
  check_single_results $exec_dir/whizzml_results.json
}

batch_rx="\"result\": \"dataset/[a-f0-9]{24}"

function check_batch_results {
  last_result=$(<$1)
  if [[ $last_result =~ $batch_rx ]]; then
      log "OK"
  else
      echo "KO: Failed batch result prediction in $1: $last_result"
      exit 1
  fi
}

function check_batch_prediction {
  log "Checking batch prediction..."
  exec_count=$((exec_count+1))
  local inputs="[[\"execution\", \"$2\"], [\"dataset\", \"$3\"]]"
  local inputs_file="$outdir/batch_inputs_$exec_count.json"
  echo $inputs > $inputs_file
  local exec_dir="$outdir/batch_$exec_count"
  run_bigmler execute --script $1 \
                      --inputs $inputs_file \
                      --output-dir $exec_dir
  check_batch_results $exec_dir/whizzml_results.json
}

log "Removing stale resources (if any)"
log "-------------------------------------------------------"
cleanup

log "Registering the package scripts in ${BIGML_DOMAIN:-bigml.io}"
log "-------------------------------------------------------"
run_bigmler whizzml --package-dir ../ --output-dir $outdir/scripts

models_script_id=$(<$outdir/scripts/create-category-models/scripts)
single_script_id=$(<$outdir/scripts/single-prediction/scripts)
batch_script_id=$(<$outdir/scripts/batch-prediction/scripts)

log "Tests for model creation scripts"
log "-------------------------------------------------------"

run_bigmler --train s3://bigml-public/csv/iris.csv --no-model \
            --project "Whizzml examples tests" --output-dir $outdir/iris
run_bigmler --train ./iris-with-missings.csv.gz --no-model \
            --project "Whizzml examples tests" --output-dir $outdir/missings

iris_id=$(<$outdir/iris/dataset)
iris_missings_id=$(<$outdir/missings/dataset)

execute_create_models $models_script_id $iris_id
ex_iris_id=$last_result
execute_create_models $models_script_id $iris_missings_id
ex_miss_id=$last_result

log "Tests for single predictions"
log "-------------------------------------------------------"

check_single_prediction $single_script_id \
                        $ex_iris_id \
                        "{\"species\": \"Iris-setosa\"}"

check_single_prediction $single_script_id $ex_miss_id "{}"

log "Tests for batch predictions"
log "-------------------------------------------------------"

check_batch_prediction $batch_script_id $ex_iris_id $iris_id
check_batch_prediction $batch_script_id $ex_iris_id $iris_missings_id
check_batch_prediction $batch_script_id $ex_miss_id $iris_missings_id
check_batch_prediction $batch_script_id $ex_miss_id $iris_id

log "Removing created resources"
log "-------------------------------------------------------"
cleanup
