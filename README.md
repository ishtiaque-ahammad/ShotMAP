# ShotMAP

## Description
ShotMAP (Shotgun Metagenomic Analysis Pipeline) is a user-friendly, automated bioinformatics pipeline designed to analyze shotgun metagenomic data. It integrates various tools to streamline the analysis workflow, offering insights into the microbial community composition and functional potential within an environmental sample.

## Features
**Quality Control:** Performs quality filtering of raw reads using fastp.

**Assembly:** Assembles cleaned reads into contigs using megahit.

**Metagenome-Assembled Genome (MAG) Assembly:** Identifies and assembles potential individual organism genomes (MAGs) from the assembled contigs using metabat2.

**MAG Quality Analysis:** Assesses the quality and completeness of assembled MAGs using checkm.

**Protein-coding Gene Prediction:** Identifies protein-coding genes within the assembled contigs using prodigal.

**Antibiotic Resistance Gene Identification:** Screens for genes associated with antibiotic resistance within the contigs using abricate.

**Carbohydrate-Active Enzyme Identification:** Identifies enzymes involved in carbohydrate metabolism using dbcan.

**Metabolic Pathway Identification:** Predicts metabolic pathways based on the identified proteins using microbe_annotator.

## Dependencies
ShotMAP relies on several software tools and requires them to be installed and configured within a conda environment. These tools include:

fastp
megahit
metabat2
checkm
prodigal
abricate
dbcan
microbeannotator

## Usage
To use ShotMAP, follow these steps:

### Clone the repository:

git clone https://github.com/yourusername/ShotMAP.git

### Navigate to the cloned directory:
cd ShotMAP

### Make the script executable:
chmod +x ShotMAP.sh

### Prepare your data:
Ensure you have your forward and reverse read files in FASTQ format with their extensions (e.g., R1.fastq.gz, R2.fastq.gz).
Decide on a sample ID for reference.
Determine the number of CPU cores available on your system.

### Run the script:
bash ShotMAP.sh

The script will prompt you for the following information:

Forward read file name
Reverse read file name
Sample ID
Number of CPU cores

### Output:
The script will create separate directories for each analysis step and store the corresponding output files.

### Runtime:
The script will display the total runtime upon successful completion.

## License
This project is licensed under the GPL-3.0 license.
