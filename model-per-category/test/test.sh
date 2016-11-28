#!/bin/bash

source ../../test-utils.sh

outdir=cmd
outdir_del=cmd_del
exec_count=0
last_result=""

function cleanup {
  [ -d $outdir ] && \
      run_bigmler delete --from-dir $outdir --output-dir $outdir_del
  rm -f -R $outdir_del $outdir .bigmler*
}

def_inputs="[\"split-field\", \"000004\"], [\"objective\", \"000002\"]"
cats_rx="\"categor(ies|y)\": \[?(\"Iris-setosa\"|\"Iris-versicolor\"|\"Iris-virginica\"[,\]\}]+)"

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

function execute_create_models_binary {
  local p="[[\"dataset\", \"$2\"], [\"binary-split\", true], $def_inputs]"
  execute_create_models "$1" "" "$p"
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

function run_exec_dataset {
  exec_count=$((exec_count+1))
  local inputs="[[\"execution\", \"$2\"], [\"dataset\", \"$3\"]]"
  local inputs_file="$outdir/$4_inputs_$exec_count.json"
  echo $inputs > $inputs_file
  local exec_dir="$outdir/$4_$exec_count"
  run_bigmler execute --script $1 \
                      --inputs $inputs_file \
                      --output-dir $exec_dir
  last_result=$exec_dir/whizzml_results.json
}

function check_batch_prediction {
  log "Checking batch prediction..."
  run_exec_dataset $1 $2 $3 "batch"
  check_batch_results $last_result
}

eval_rx="\"result\": \{.*\"evaluations\": \[(\"evaluation/[a-f0-9]{24}\"[, ])+"

function check_eval_results {
  last_result=$(<$1)
  if [[ $last_result =~ $eval_rx ]]; then
      log "OK"
  else
      echo "KO: Failed evaluation result in $1: $last_result"
      exit 1
  fi
}

function check_evaluation {
  log "Checking evaluation..."
  run_exec_dataset $1 $2 $3 "eval"
  check_eval_results $last_result
}

log "Removing stale resources (if any)"
log "-------------------------------------------------------"
cleanup

log "Registering the package scripts in ${BIGML_DOMAIN:-bigml.io}"
log "-------------------------------------------------------"
run_bigmler whizzml --package-dir ../ --output-dir $outdir/scripts || \
    (echo "KO: Failed to create whizzml package"; exit 1)

models_script_id=$(<$outdir/scripts/create-category-models/scripts)
single_script_id=$(<$outdir/scripts/single-prediction/scripts)
batch_script_id=$(<$outdir/scripts/batch-prediction/scripts)
eval_script_id=$(<$outdir/scripts/evaluation/scripts)

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
execute_create_models_binary $models_script_id $iris_missings_id
ex_bin_id=$last_result

log "Tests for single predictions"
log "-------------------------------------------------------"

check_single_prediction $single_script_id \
                        $ex_iris_id \
                        "{\"species\": \"Iris-setosa\"}"

check_single_prediction $single_script_id $ex_miss_id "{}"
check_single_prediction $single_script_id $ex_miss_id "{\"sepal width\": 0.1}"

check_single_prediction $single_script_id $ex_bin_id "{}"
check_single_prediction $single_script_id \
                        $ex_bin_id \
                        "{\"species\": \"Iris-versicolor\", \"petal length\": 1}"

log "Tests for batch predictions"
log "-------------------------------------------------------"

for s in $ex_iris_id $ex_miss_id $ex_bin_id; do
    check_batch_prediction $batch_script_id $s $iris_id
    check_batch_prediction $batch_script_id $s $iris_missings_id
done

log "Tests for evaluations"
log "-------------------------------------------------------"
for s in $ex_iris_id $ex_miss_id $ex_bin_id; do
    check_evaluation $eval_script_id $s $iris_id
    check_evaluation $eval_script_id $s $iris_missings_id
done


log "Removing created resources"
log "-------------------------------------------------------"
cleanup
