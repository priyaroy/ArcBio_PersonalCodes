#!/bin/bash

export pathtolibdir=$1
export run_name=$2
export date=$3
export fastp=/mnt/bdbStorage01/programs/fastp/fastp
export logdir=~/standalone_scripts/logs/$run_name$date

#Create a new directory for log files

echo $logdir
mkdir $logdir

# Start running the fastq to trimmmed fastq conversion code
cd $pathtolibdir

count=0

for dir in Lib*; do
    cd $dir;  #Enter each library
    count=$((count+1))
    file1=$(find . -maxdepth 1 -name "*_R1_*");
    file2=$(find . -maxdepth 1 -name "*_R2_*");

    #Remove './' from the filenames of file1 and file2
    file1=${file1#*/}
    file2=${file2#*/}

    trimmed_file1="TRIMMED_R1_$file1"
    trimmed_file2="TRIMMED_R2_$file2"
    jsonfile="fastp_report.json"
    htmlf="fastp_report.html"

    if [ $count -ge 0 ]; then
      echo $fastp
      echo $file1 
      echo $file2
      echo $trimmed_file1
      echo $trimmed_file2
      
      mkdir fastp

      stdbuf -oL $fastp -i $file1 -I $file2 -o fastp/$trimmed_file1 -O fastp/$trimmed_file2 --adapter_sequence 'TACACTCTTTCCCTACACGACGCTCTTCCGATCT' --adapter_sequence_r2 'GTGACTGGAGTTCAGACGTGTGCTCTTCCGATCT' -g -x -5 -3 -W 7 -M 15 -Q -l 37 > $logdir/log_trimmedFastq_$count 2>$logdir/error_trimmedFastq_$count -j fastp/$jsonfile -h fastp/$htmlf -w 1
    fi
    cd ..
done

echo "DONE!"
