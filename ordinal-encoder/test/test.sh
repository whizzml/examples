#!/bin/bash

source ../../test-utils.sh

outdir=cmd
outdir_del=cmd_del

function cleanup {
  [ -d $outdir ] && \
      run_bigmler delete --from-dir $outdir --output-dir $outdir_del
  [ -d .build ] && \
      run_bigmler delete --from-dir .build --output-dir $outdir_del
  rm -f -R data.csv test_inputs.json
  rm -f -R $outdir $outdir_del .build .bigmler* storage
}

function run_test {
  data=$1
  inputs=$2
  expected=$3

  log "Removing stale resources (if any)"
  cleanup

  run_bigmler whizzml --package-dir ../ --output-dir ./.build

  log "Creating input dataset..."
  echo "$data" > data.csv
  run_bigmler --train "data.csv" --no-model --output-dir $outdir/ds
  [ $? != 0 ] && echo "KO: Failed to create dataset" && exit 1
  dataset_id=$(<$outdir/ds/dataset)
  log "Dataset $dataset_id created"

  log "Executing script..."
  echo "${inputs/\%DATASET_ID\%/$dataset_id}" > test_inputs.json
  run_bigmler execute --scripts .build/scripts  --inputs test_inputs.json \
      --output-dir $outdir/results

  log "Downloading output dataset..."
  output_dataset_id=$(cat $outdir/results/whizzml_results.txt | grep "\'result\'" | cut -f4 -d\')
  run_bigmler --dataset "$output_dataset_id" --to-csv "output_dataset.csv" --no-model --output-dir $outdir/results
  actual=$(cat $outdir/results/output_dataset.csv)

  log "Comparing actual result to expected..."
  if [ "$actual" = "$expected" ]; then
    log "PASS"
  else
    log "FAIL"
    echo "Expected"
    echo "$expected"
    echo "Actual"
    echo "$actual"
    exit 1
  fi
  cleanup
}


log "-------------------------------------------------------"
log "Tests for ordinal-encoder script"

data=$(cat <<'EOF'
id,size,code
0,XL,C
1,S,A
2,M,C
3,M,B
4,S,B
5,L,C
6,XL,C
7,M,A
EOF
)

log "Test: Default inputs"
inputs=$(cat <<EOF
[["input-dataset-id", "%DATASET_ID%"]]
EOF
)
expected=$(cat <<'EOF'
id,size,code,size_ordinal,code_ordinal
0,XL,C,2,0
1,S,A,1,1
2,M,C,0,0
3,M,B,0,2
4,S,B,1,2
5,L,C,3,0
6,XL,C,2,0
7,M,A,0,1
EOF
)
run_test "$data" "$inputs" "$expected"


log "Test: Target fields"
inputs=$(cat <<EOF
[["input-dataset-id", "%DATASET_ID%"],
 ["target-fields", ["size"]]]
EOF
)
expected=$(cat <<'EOF'
id,size,code,size_ordinal
0,XL,C,2
1,S,A,1
2,M,C,0
3,M,B,0
4,S,B,1
5,L,C,3
6,XL,C,2
7,M,A,0
EOF
)
run_test "$data" "$inputs" "$expected"


log "Test: Target fields by id"
inputs=$(cat <<EOF
[["input-dataset-id", "%DATASET_ID%"],
 ["target-fields", ["size", "000002"]]]
EOF
)
expected=$(cat <<'EOF'
id,size,code,size_ordinal,code_ordinal
0,XL,C,2,0
1,S,A,1,1
2,M,C,0,0
3,M,B,0,2
4,S,B,1,2
5,L,C,3,0
6,XL,C,2,0
7,M,A,0,1
EOF
)
run_test "$data" "$inputs" "$expected"


log "Test: Mappings"
inputs=$(cat <<EOF
[["input-dataset-id", "%DATASET_ID%"],
 ["target-fields", ["size"]],
 ["mappings", {"size": {"S": 0,
                        "M": 1,
                        "L": 2,
                        "XL": 3}}]]
EOF
)
expected=$(cat <<'EOF'
id,size,code,size_ordinal
0,XL,C,3
1,S,A,0
2,M,C,1
3,M,B,1
4,S,B,0
5,L,C,2
6,XL,C,3
7,M,A,1
EOF
)
run_test "$data" "$inputs" "$expected"


log "Test: Missing value in mapping"
inputs=$(cat <<EOF
[["input-dataset-id", "%DATASET_ID%"],
 ["target-fields", ["size"]],
 ["mappings", {"size": {"S": 0,
                        "L": 2,
                        "XL": 3}}]]
EOF
)
expected=$(cat <<'EOF'
id,size,code,size_ordinal
0,XL,C,3
1,S,A,0
2,M,C,
3,M,B,
4,S,B,0
5,L,C,2
6,XL,C,3
7,M,A,
EOF
)
run_test "$data" "$inputs" "$expected"


log "Test: Non-categorical target field"
inputs=$(cat <<EOF
[["input-dataset-id", "%DATASET_ID%"],
 ["target-fields", ["id", "size"]]]
EOF
)
expected=$(cat <<'EOF'
id,size,code,size_ordinal
0,XL,C,2
1,S,A,1
2,M,C,0
3,M,B,0
4,S,B,1
5,L,C,3
6,XL,C,2
7,M,A,0
EOF
)
run_test "$data" "$inputs" "$expected"

log "Test: No categorical fields"
inputs=$(cat <<EOF
[["input-dataset-id", "%DATASET_ID%"],
 ["target-fields", ["id"]]]
EOF
)
expected=
run_test "$data" "$inputs" "$expected"


log "Test: Unknown target field"
inputs=$(cat <<EOF
[["input-dataset-id", "%DATASET_ID%"],
 ["target-fields", ["foo", "size"]]]
EOF
)
expected=$(cat <<'EOF'
id,size,code,size_ordinal
0,XL,C,2
1,S,A,1
2,M,C,0
3,M,B,0
4,S,B,1
5,L,C,3
6,XL,C,2
7,M,A,0
EOF
)
run_test "$data" "$inputs" "$expected"


log "Test: Mapping by field id"
inputs=$(cat <<EOF
[["input-dataset-id", "%DATASET_ID%"],
 ["mappings", {"000002": {"A": 0,
                          "B": 1,
                          "C": 2},
               "size": {"S": 0,
                        "M": 1,
                        "L": 2,
                        "XL": 3}}]]
EOF
)
expected=$(cat <<'EOF'
id,size,code,size_ordinal,code_ordinal
0,XL,C,3,2
1,S,A,0,0
2,M,C,1,2
3,M,B,1,1
4,S,B,0,1
5,L,C,2,2
6,XL,C,3,2
7,M,A,1,0
EOF
)
run_test "$data" "$inputs" "$expected"



