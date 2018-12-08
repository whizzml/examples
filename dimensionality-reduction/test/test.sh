#!/bin/bash

source ../../test-utils.sh

outdir=cmd
outdir_del=cmd_del

function cleanup {
  [ -d $outdir ] && \
    run_bigmler delete --from-dir $outdir --output-dir $outdir_del
  rm -f -R $outdir_del $outdir .bigmler* storage

}

log "Testing dimensionality-reduction"
log "-------------------------------------------------------"


log "Removing stale resources (if any)"
log "-------------------------------------------------------"
cleanup

log "Registering the package script in ${BIGML_DOMAIN:-bigml.io}"
log "-------------------------------------------------------"
run_bigmler whizzml --package-dir ../ --output-dir $outdir/scripts
script_id=$(<$outdir/scripts/scripts)

log "Creating dataset"
log "-------------------------------------------------------"
run_bigmler --train s3://bigml-public/csv/stumbleupon_evergreen.tsv --no-model \
            --project "Whizzml examples tests" --output-dir $outdir/ds
[ $? != 0 ] && echo "KO: Failed to create dataset" && exit 1
dataset_id=$(<$outdir/ds/dataset)

log "Executing script on dataset using series workflow"
log "-------------------------------------------------------"
ins="$outdir/in.json"
echo "[[\"dataset-id\", \""$dataset_id"\"]]" > $ins
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

diffresult=$(diff $outdir/sample/sample.csv reference-series.csv)

[ -n "$diffresult" ] &&
  echo "KO: Unexpected final dataset contents" &&
  echo $diffresult  && exit 1

log "Executing script on dataset using parallel workflow"
log "-------------------------------------------------------"
ins="$outdir/in.json"
echo "[[\"dataset-id\", \""$dataset_id"\"], [\"lda-first\", false]]" > $ins
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

diffresult=$(diff $outdir/sample/sample.csv reference-parallel.csv)

[ -n "$diffresult" ] &&
  echo "KO: Unexpected final dataset contents" &&
  cat $outdir/sample/sample.csv && exit 1

log "Removing created resources"
log "-------------------------------------------------------"
cleanup
