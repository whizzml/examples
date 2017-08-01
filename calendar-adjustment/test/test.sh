#!/bin/bash

source ../../test-utils.sh

outdir=cmd
outdir_del=cmd_del
exec_count=0
last_result=""
data="input.csv"
reference="reference.csv"

function create_data {
  cat > $1 <<EOF
date,series
"1962-10",577
"1962-11",553
"1962-12",582
"1963-01",600
"1963-02",566
"1963-03",653
"1963-04",673
"1963-05",742
"1963-06",716
"1963-07",660
"1963-08",617
"1963-09",583
"1963-10",587
"1963-11",565
"1963-12",598
"1964-01",628
"1964-02",618
"1964-03",688
"1964-04",705
"1964-05",770
"1964-06",736
EOF
}

function cleanup {
  [ -d $outdir ] && \
    run_bigmler delete --from-dir $outdir --output-dir $outdir_del
  rm -f -R $outdir_del $outdir .bigmler* storage
  rm -f ./$data
}

log "Testing calendar-adjustment"

log "Removing stale resources (if any)"
log "-------------------------------------------------------"
cleanup

log "Registering the package script in ${BIGML_DOMAIN:-bigml.io}"
log "-------------------------------------------------------"
run_bigmler whizzml --package-dir ../ --output-dir $outdir/scripts

[ $? != 0 ] && echo "KO: Failed to create whizzml package" && exit 1

script_id=$(<$outdir/scripts/scripts)

create_data $data
run_bigmler --train $data --no-model --output-dir $outdir/ds

[ $? != 0 ] && echo "KO: Failed to create dataset" && exit 1

dataset_id=$(<$outdir/ds/dataset)

log "Dataset $dataset_id created"
log "-------------------------------------------------------"
log "Executing script on dataset"
log "-------------------------------------------------------"
ins="$outdir/in.json"
echo "[[\"id\", \""$dataset_id"\"]]" >> $ins
run_bigmler execute --script $script_id \
            --inputs $ins \
            --output-dir $outdir/exec

new_id=$(grep -Eo 'dataset/[0-9a-f]{24}' $outdir/exec/whizzml_results.json|head -1)

[ -z $new_id ] && echo "KO: no dataset found in results" && exit 1

log "Dataset $new_id created by script"
log "-------------------------------------------------------"
log "Checking results"

run_bigmler sample --dataset $new_id --mode linear --rows 100 \
            --sample-header --output-dir $outdir/sample

diffresult=$(diff $outdir/sample/sample.csv $reference)

[ -n "$diffresult" ] &&
  echo "KO: Unexpected final dataset contents" &&
  cat $outdir/sample/sample.csv && exit 1

log "Removing created resources"
log "-------------------------------------------------------"
cleanup
