#!/bin/bash

source PROGRAMPATHS
source PARAMETERS
source DIRECTORIES

if [ $MERGE -eq 0 ] ; then
	R1=$1
	I1=$2
	I2=$3
	TSAMDIR=$SAMDIR
	TBAMDIR=$BAMDIR
	TSORTEDDIR=$SORTEDDIR
	TREPORTSDIR=$REPORTSDIR
elif [ $MERGE -eq 1 ] ; then
	R1=$1
	DIR=$2
	I1=$3
	I2=$4
	TSAMDIR=$SAMDIR/$DIR
	TBAMDIR=$BAMDIR/$DIR
	TSORTEDDIR=$SORTEDDIR/$DIR
	TREPORTSDIR=$REPORTSDIR/alignment/$DIR

	mkdir -p $TSAMDIR
	mkdir -p $TBAMDIR
	mkdir -p $TSORTEDDIR
	mkdir -p $TREPORTSDIR
fi

REFERENCE=$R1
INPUT1=$I1
INPUT2=$I2

OUTPUT=`echo $INPUT1 | sed 's/\// /g' | awk '{print $NF}' | sed 's/\_R[0-9]_/ /g' | awk '{print $1}'`
SAM=$TSAMDIR/$OUTPUT.sam
BAM=$TBAMDIR/$OUTPUT.bam
SORTED=$TSORTEDDIR/$OUTPUT"_sorted.bam"
REPORT=$TREPORTSDIR/$OUTPUT"_alignment_report.txt"
ID=`echo $I1 | sed 's/\// /g' | awk '{print $NF}' | sed 's/\_R[0-9]_/ /g' | awk '{print $1}'`

echo "Aligning $INPUT1 and $INPUT2 ..."
$BWA mem $BWAOPTIONS $REFERENCE $INPUT1 $INPUT2 > $SAM
wait
echo "Done!"
echo " "
echo "Converting $SAM to $BAM ..."
$SAMTOOLS view -bS $SAM -o $BAM
wait
echo "Done!"
echo " "
echo "Sorting $BAM ..."
$SAMTOOLS sort $BAM -o $SORTED
wait
echo "Done!"
echo " "
echo "Indexing $SORTED ..."
$SAMTOOLS index $SORTED
wait
echo "Done!"
echo " "
echo "--------------------------------------------------------" > $REPORT
echo "Alignment Report For: $ID" >> $REPORT
echo "--------------------------------------------------------" >> $REPORT
$BAMTOOLS stats -in $BAM >> $REPORT
wait
echo " " >> $REPORT
echo " " >> $REPORT
echo " " >> $REPORT
