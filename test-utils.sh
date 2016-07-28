# Shared functions and variables for test scripts

BIGMLER=${BIGMLER:-bigmler}
VERBOSITY=${VERBOSITY:-0}
BML_VERBOSITY=$(if [ $VERBOSITY == 2 ]; then echo 1; else echo 0; fi)

log () {
    [ $VERBOSITY == 0 ] || echo $1
}

run_bigmler () {
    ${BIGMLER} "$@" --verbosity $BML_VERBOSITY
}
