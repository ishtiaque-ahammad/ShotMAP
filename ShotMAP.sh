#!/bin/bash
SECONDS=0

echo "Welcome to ShotMAP (Shotgun Metagenomic Analysis Pipeline)"

sleep 5s
read -e -p "Please provide your forward read file name (with extension i.e. R1.fastq.gz) : " R1
read -e -p "Please provide your reverse read file name (with extension i.e. R1.fastq.gz) : " R2
read -e -p "What is your sample ID: " sample_ID 
read -e -p "Please provide number of CPU cores: " core
echo "Thanks for providing the neccessary information! Let's start!"
sleep 5s

mkdir ${sample_ID}_fastp_output ${sample_ID}_CAT_output ${sample_ID}_BAT_output ${sample_ID}_metabat2_output ${sample_ID}_prodigal_output ${sample_ID}_CheckM_output ${sample_ID}_abricate_output ${sample_ID}_dbcan_output

#fastp
#activate the fastp environment
eval "$(conda shell.bash hook)"
conda activate fastp

echo "Starting Quality Control of ${R1} and ${R2}!"

sleep 5s

fastp -i ${R1}  -I ${R2} -o ${sample_ID}_fastp_output/trimmed_paired_${R1} -O ${sample_ID}_fastp_output/trimmed_paired_${R2} --thread ${core} 
mv fastp.html ${sample_ID}_fastp_output/quality_control_summary.html
rm fastp.json

echo "Quality Control of ${R1} and ${R2} Finished!"

sleep 5s

#megahit
#activate the megahit environment
eval "$(conda shell.bash hook)"
conda activate megahit

echo "Starting Metagenome Assembly!"

sleep 5s

megahit -1 ${sample_ID}_fastp_output/trimmed_paired_${R1} -2 ${sample_ID}_fastp_output/trimmed_paired_${R2} -o ${sample_ID}_megahit_output --out-prefix ${sample_ID} -t ${core}

echo "Metagenome Assembly Finished!"

sleep 5s

#metabat2
#activate the metabat2 environment
eval "$(conda shell.bash hook)"
conda activate metabat2

echo "Starting Metagenome-Assembled Genome (MAG) Assembly!"

sleep 5s

metabat2 -i ${sample_ID}_megahit_output/${sample_ID}.contigs.fa -o ${sample_ID}_metabat2_output/${sample_ID}_bin -t ${core}

echo "Metagenome Assembled-Genome (MAG) Assembly Finished!"
 
sleep 5s 

#CheckM
#activate the checkm environment
eval "$(conda shell.bash hook)"
conda activate checkm

echo "Starting Metagenome Assembled-Genome (MAG) Quality Analysis!"

sleep 5s

checkm lineage_wf -t ${core} -x fa ./${sample_ID}_metabat2_output/ ./${sample_ID}_CheckM_output/
checkm qa ./${sample_ID}_CheckM_output/lineage.ms ./${sample_ID}_CheckM_output/ -o 1 --tab_table -f ./${sample_ID}_CheckM_output/${sample_ID}_CheckM_output

echo "Metagenome Assembled-Genome (MAG) Quality Analysis Finished!"

sleep 5s

#prodigal
#activate the prodigal environment
eval "$(conda shell.bash hook)"
conda activate prodigal

echo "Starting Protein-coding Gene Identification!"
 
sleep 5s 

prodigal -i ${sample_ID}_megahit_output/${sample_ID}.contigs.fa -a ./${sample_ID}_prodigal_output/${sample_ID}_proteins.faa -p meta -q

echo "Protein-coding Gene Identification Finished!"
 
sleep 5s 

#abricate
#activate the abricate environment
eval "$(conda shell.bash hook)"
conda activate abricate

echo "Starting Antibiotic Resistant Gene Identification"
 
sleep 5s 

abricate ${sample_ID}_megahit_output/${sample_ID}.contigs.fa > ${sample_ID}_abricate_output/${sample_ID}_abricate.tsv

echo "Antibiotic Resistant Gene Identification Finished!"
 
sleep 5s 

#dbcan
#activate the dbcan environment
eval "$(conda shell.bash hook)"
conda activate dbcan

echo "Starting Carbohydrate-active Enzyme Identification!"

sleep 5s 

run_dbcan.py ./${sample_ID}_prodigal_output/${sample_ID}_proteins.faa protein --db_dir /media/bioinfo/Data_3/genome_assembly/software/dbcan/db -t hotpep --dia_cpu ${core} --hotpep_cpu 64 --tf_cpu ${core} --out_pre ${sample_ID}_dbcan_ --out_dir ${sample_ID}_dbcan_output

rm -r Hotpep -f

echo "Carbohydrate-active Enzyme Identification Finished."

sleep 5s

#microbe_annotator
#activate the microbeannotator environment
eval "$(conda shell.bash hook)"
conda activate microbeannotator

echo "Starting Metabolic Pathway Identification!"
 
sleep 5s 

microbeannotator -i ${sample_ID}_prodigal_output/${sample_ID}_proteins.faa -d /media/bioinfo/Data_3/genome_assembly/software/microbe_annotator/MicrobeAnnotator_DB -o ${sample_ID}_microbe_annotator_output -m diamond -p 1 -t ${core} --light

echo "Metabolic Pathway Identification Finished!"
 
sleep 5s

duration=$SECONDS

echo "Thanks for using ShotMAP! It took $(($duration / 60)) minutes and $(($duration % 60)) seconds to run!"
