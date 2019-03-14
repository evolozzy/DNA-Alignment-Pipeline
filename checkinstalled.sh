#!/bin/bash

source PROGRAMPATHS
source DIRECTORIES
source PARAMETERS

tmpfile="$WD/checkinstalled.tmp"

rm -f $tmpfile
touch $tmpfile

JAVP=`$JAVA -version 2>&1`
if [ -z "$JAVP" ]
then
	echo "java is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "java is installed" >> $tmpfile
fi
rm -f 1


PICNP=`ls $PICARDP`
if [ -z "$PICNP" ]
then
	echo "picard.jar is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "picard.jar is installed" >> $tmpfile
fi


SAMP=`$SAMTOOLS --version`
if [ -z "$SAMP" ]
then
	echo "samtools is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "samtools is installed" >> $tmpfile
fi


BAMP=`$BAMTOOLS --version`
if [ -z "$BAMP" ]
then
	echo "bamtools is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "bamtools is installed" >> $tmpfile
fi


VUTP=`ls $VCFUTILS`
if [ -z "$VUTP" ]
then
	echo "vcfutils.pl is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "vcfutils.pl is installed" >> $tmpfile
fi


BCFP=`$BCFTOOLS -v`
if [ -z "$BCFP" ]
then
	echo "bcfools is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "bcftools is installed" >> $tmpfile
fi


SQTP=`$SEQTK 2>&1 | grep "Version"`
if [ -z "$SQTP" ]
then
	echo "seqtk is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "seqtk is installed" >> $tmpfile
fi


BWAP=`$BWA 2>&1 | grep "Version"`
if [ -z "$BWAP" ]
then
	echo "bwa is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "bwa is installed" >> $tmpfile
fi

TGLP=`$TRIMGALORE --version`
if [ -z "$TGLP" ]
then
	echo "trim_galore is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "trim_galore is installed" >> $tmpfile
fi


FBYP=`$FREEBAYES --version`
if [ -z "$FBYP" ]
then
	echo "freebayes is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "freebayes is installed" >> $tmpfile
fi


CTAP=`$CUTADAPT --version`
if [ -z "$CTAP" ]
then
	echo "cutadapt is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
else
	echo "cutadapt is installed" >> $tmpfile
fi


FASTQCPATH=`echo $FASTQC | sed 's_/fastqc__g'`
CHECKFQCPATH=`echo $PATH | grep $FASTQCPATH`
if [ -z "$CHECKFQCPATH" ]
then
	PATH=$PATH:$FASTQCPATH
	export PATH=$PATH
	echo "FastQC path is added to the path"
	echo "New Path is:"
	echo $PATH
fi


FQCP=`fastqc --version`
if [ ! -z "$FQCP" ]
then
	echo "fastqc is installed" >> $tmpfile
else
	echo "fastqc is not installed or wrong path in PROGRAMPATHS file." >> $tmpfile
fi

cat $tmpfile
