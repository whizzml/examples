#!/bin/bash

source ../../test-utils.sh

outdir=cmd
outdir_del=cmd_del
exec_count=0
last_result=""
data="input1.csv"
bad_data="input2.csv"
reference="reference.csv"

function create_data {
  cat > "$1" <<EOF
license-plates,state
495GIN,AL
927NIM,AK
027MOL,AZ
557NDK,AR
13238D,CO
JDH345,CT
354858,DE
DJKL34,FL
102CSV,OR
343JKD,GA
894SLS,HA
784930,ID
782627,IL
780392,IN
223UDK,IO
473AAS,KS
137IOL,KY
809DVV,LA
782634,ME
783627,MD
595GIN,MA
027NIM,MI
127MOL,MN
657NDK,MS
23238D,MO
JDH445,MT
454858,NE
573AAS,NV
237IOL,NH
909DVV,NJ
882634,NM
883627,NY
DJKL44,NC
202CSV,ND
443JKD,OH
994SLS,OK
884930,PA
882627,RI
880392,SC
323UDK,SD
EOF
}

function create_bad_data {
  cat > "$1" <<EOF
license-plates,state
780985,CA
789362,CA
787463,CA
781163,CA
785757,CA
EOF
}

function cleanup {
  [ -d $outdir ] && \
    run_bigmler delete --from-dir $outdir --output-dir $outdir_del
  rm -f -R $outdir_del $outdir .bigmler* storage
  rm -f ./$data
  rm -f ./$bad_data
}

log "Testing unify-optype"

log "Removing stale resources (if any)"
log "-------------------------------------------------------"
cleanup

log "Registering the package script in ${BIGML_DOMAIN:-bigml.io}"
log "-------------------------------------------------------"
run_bigmler whizzml --package-dir ../ --output-dir $outdir/scripts

[ $? != 0 ] && echo "KO: Failed to create whizzml package" && exit 1

script_id=$(<$outdir/scripts/scripts)

create_bad_data $bad_data
run_bigmler --train $bad_data --no-dataset --output-dir $outdir/ds

[ $? != 0 ] && echo "KO: Failed to create dataset" && exit 1

source_id=$(head -n 1 <$outdir/ds/source  )

log "Source $source_id created"

create_data $data
run_bigmler --train $data --no-model --output-dir $outdir/ds

[ $? != 0 ] && echo "KO: Failed to create dataset" && exit 1

dataset_id=$(<$outdir/ds/dataset)

log "Dataset $dataset_id created"
log "-------------------------------------------------------"


log "Executing script on dataset"
log "-------------------------------------------------------"
ins="$outdir/in.json"

echo "[[\"template-dataset\", \""$dataset_id"\"], [\"source\", \""$source_id"\"]]" >> $ins
run_bigmler execute --script $script_id \
            --inputs $ins \
            --output-dir $outdir/exec

new_id=$(grep -Eo 'dataset/[0-9a-f]{24}' $outdir/exec/whizzml_results.json|head -1)

[ -z $new_id ] && echo "KO: no dataset found in results" && exit 1

log "Dataset $new_id created by script"
log "-------------------------------------------------------"
log "Checking results"

run_bigmler --source $source_id \
            --no-dataset \
            --output-dir $outdir/results \
            --store

underscore_source=${source_id////_}
results="$outdir/results/$underscore_source" 

if grep -q "{\"000000\": {\"order\": 0, \"optype\": \"text\"" $results
then
    log "unify-optype OK"
else
    echo "KO: optype not set properly in results" 
    exit 1
fi

log "Removing created resources"
log "-------------------------------------------------------"
cleanup

