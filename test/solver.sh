#!/bin/sh
#OAR -l /core=1,walltime=24:00:00
#OAR -t besteffort


INST=`basename $2`
echo "i $INST"
echo "s SAT"
echo "o $RANDOM"
echo "o $RANDOM"
echo "v $RANDOM $RANDOM"
echo "v $RANDOM $RANDOM $RANDOM"
echo "v "
echo "d ALGO $1"
echo "d SEED $3"
echo "d OAR_JOB_ID $OAR_JOB_ID"
echo "c Fake solver for demonstration" 
 
echo "stderr $INST "`basename $1` >&2 
exit $?
