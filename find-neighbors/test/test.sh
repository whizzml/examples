#!/bin/bash

source ../../test-utils.sh

outdir=cmd
outdir_del=cmd_del
exec_count=0
last_result=""
data="input.csv"

function create_data {
  cat > $1 <<EOF
title,price,year
foo,7.8,2017
bar,5.7,2018
lag,6.8,2018
EOF
}

function cleanup {
  [ -d $outdir ] && \
    run_bigmler delete --from-dir $outdir --output-dir $outdir_del
  rm -f -R $outdir_del $outdir .bigmler* storage
  rm -f ./$data
}

log "Testing find-neighbors"
log "-------------------------------------------------------"
log "Removing stale resources (if any)"
log "-------------------------------------------------------"
cleanup

log "Registering the package script in ${BIGML_DOMAIN:-bigml.io}"
log "-------------------------------------------------------"
run_bigmler whizzml --package-dir ../ --output-dir $outdir/scripts

[ $? != 0 ] && echo "KO: Failed to create whizzml package" && exit 1

script_id=$(<$outdir/scripts/scripts)

create_data $data
run_bigmler cluster --train $data --output-dir $outdir/cls --k 1

[ $? != 0 ] && echo "KO: Failed to create dataset and cluster" && exit 1

dataset_id=$(<$outdir/cls/dataset)
cluster_id=$(<$outdir/cls/clusters)

log "Dataset $dataset_id created and cluster $cluster_id created"
log "-------------------------------------------------------"
log "Executing script on cluster"
log "-------------------------------------------------------"
ins="$outdir/in.json"
cat > $ins <<EOF
[["cluster-id", "$cluster_id"],
 ["n", 1],
 ["instance", {"price": 5.7, "year": 2018}]]
EOF
run_bigmler execute --script $script_id \
            --inputs $ins \
            --output-dir $outdir/exec

log "Checking results"
log "-------------------------------------------------------"
resfile=$outdir/exec/whizzml_results.txt
match=$(cat $resfile|grep "'result': \[\[5.7, 2018, 0.0\]\]")
[ $? != 0 ] && echo "KO: Unexpected result in $resfile" && exit 2

log "Removing created resources"
log "-------------------------------------------------------"
cleanup
