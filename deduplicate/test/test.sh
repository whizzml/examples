#!/bin/bash

source ../../test-utils.sh

outdir=cmd
outdir_del=cmd_del
exec_count=0
last_result=""
data="dups.csv"

function create_data {
  cat > $1 <<EOF
a,2,3
a,2,2
a,2,4
b,1,1
b,2,1
c,0,0
d,1,1
d,2,2
d,3,3
d,4,4
d,4,4
EOF
}

function cleanup {
  [ -d $outdir ] && \
      run_bigmler delete --from-dir $outdir --output-dir $outdir_del
  rm -f -R $outdir_del $outdir .bigmler* storage
  rm -f ./$data
}

log "Removing stale resources (if any)"
log "-------------------------------------------------------"
cleanup

log "Registering the package script in ${BIGML_DOMAIN:-bigml.io}"
log "-------------------------------------------------------"
run_bigmler whizzml --package-dir ../ --output-dir $outdir/scripts

[ $? != 0 ] && echo "KO: Failed to create whizzml package" && exit 1

script_id=$(<$outdir/scripts/scripts)

log "Creating data CSV in $data and a dataset with it..."
log "-------------------------------------------------------"
create_data $data
run_bigmler --train $data --no-model --output-dir $outdir/ds

[ $? != 0 ] && echo "KO: Failed to create dataset" && exit 1

dataset_id=$(<$outdir/ds/dataset)

log "Dataset $dataset_id created"
log "-------------------------------------------------------"
log "Executing script on dataset"
log "-------------------------------------------------------"
ins="$outdir/in.json"
echo "[[\"dataset-id\", \""$dataset_id"\"],[\"field\", \"000000\"]]" >> $ins
run_bigmler execute --script $script_id \
                    --inputs $ins \
                    --output-dir $outdir/exec

new_id=$(grep -Eo 'dataset/[0-9a-f]{24}' $outdir/exec/whizzml_results.json|head -1)

[ -z $new_id ] && echo "KO: no dataset found in results" && exit 1

log "Dataset $new_id created by script"
log "-------------------------------------------------------"
log "Checking results"
log "-------------------------------------------------------"
run_bigmler sample --dataset $new_id --mode linear --rows 100 \
                   --output-dir $outdir/sample

output=$(cut -f 1 -d , < $outdir/sample/sample.csv)

[ "x$(echo $output)" != "xa b c d" ] &&
    echo "KO: Unexpected final dataset contents: $output" && exit 1

log "Removing created resources"
log "-------------------------------------------------------"
cleanup
