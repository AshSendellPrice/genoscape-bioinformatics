#!/bin/bash
#$ -cwd
#$ -V
#$ -N clean-up
#$ -o clean-up.log
#$ -e clean-up.error
#$ -pe shared 1
#$ -l highp,h_data=2G,time=1:20:00
#$ -M eric.anderson@noaa.gov
#$ -m bea

# This should be run from the top level of the Plate_X directory
# but should not be run using qsub.  It is not compute-intensive
# However, it can be run under qsub if desired.


source data-defs.sh 
source $PROGDEFS


if [ ! -d Logs ]; then 
  mkdir Logs
fi


awk '
  BEGIN {
    OFS="\t";
    print file1,file2,num_clones,num_seqs;
  }
  /^Reading data from:/ {fline=0; next} 
  fline==0 {f1=$1; fline++; next} 
  fline==1 {f2=$1; fline++; next;}  
  /^Num Clones/ {go=1; next}  
  /^[0-9]* pairs of reads/ {go=0; next} 
  go==1 {print f1, f2, $1, $2}
' dupfiltered/clone_filter_report.stdout > Logs/clone_counts.txt