# ShotMAP

## Description
ShotMAP (Shotgun Metagenomic Analysis Pipeline) is a user-friendly, automated bioinformatics pipeline designed to analyze shotgun metagenomic data. It integrates various tools to streamline the analysis workflow, offering insights into the microbial community composition and functional potential within an environmental sample.

## Features
**Quality Control:** Performs quality filtering of raw reads using fastp.

**Assembly:** Assembles cleaned reads into contigs using megahit.

**Metagenome-Assembled Genome (MAG) Assembly:** Identifies and assembles potential Metagenome-assembled genomes (MAGs) from the assembled contigs using metabat2.

**MAG Quality Analysis:** Assesses the quality and completeness of assembled MAGs using checkm.

**Protein-coding Gene Prediction:** Identifies protein-coding genes within the assembled contigs using prodigal.

**Antibiotic Resistance Gene Identification:** Screens for genes associated with antibiotic resistance within the contigs using abricate.

**Carbohydrate-Active Enzyme Identification:** Identifies enzymes involved in carbohydrate metabolism using dbcan.

**Metabolic Pathway Identification:** Predicts metabolic pathways based on the identified proteins using microbeannotator.

## Dependencies
ShotMAP relies on several software tools and requires them to be installed. These tools include:

* [fastp](https://github.com/OpenGene/fastp)

* [megahit](https://github.com/voutcn/megahit)

* [metabat2](https://github.com/linsalrob/ComputationalGenomicsManual/blob/master/CrossAssembly/Metabat.md)
 
* [checkm](https://github.com/Ecogenomics/CheckM)

* [prodigal](https://github.com/hyattpd/Prodigal)

* [abricate](https://github.com/tseemann/abricate)

* [dbcan](https://github.com/linnabrown/run_dbcan)

* [microbeannotator](https://github.com/cruizperez/MicrobeAnnotator)

## Installation

### Clone the repository
``` git clone https://github.com/ishtiaque-ahammad/ShotMAP ```

### Navigate to the cloned directory
``` cd ShotMAP ```

### Make the script executable
``` chmod +x ShotMAP.sh ```

### Install dependencies
``` conda env create --file fastp.yml ```

``` conda env create --file megahit.yml ```

``` conda env create --file metabat2.yml ```

``` conda env create --file checkm.yml ```

``` conda env create --file prodigal.yml ```

``` conda env create --file abricate.yml ```

``` conda env create --file dbcan.yml ```

``` conda env create --file microbeannotator.yml ```

## Usage

### Prepare your data

Ensure you have your forward and reverse read files in fastq / fastq.gz format with their extensions (e.g., R1.fastq.gz, R2.fastq.gz).

### Run the script
```  bash ShotMAP.sh ``` 

### Output
The script will create separate directories for each analysis step and store the corresponding output files.

### Runtime
The script will display the total runtime upon successful completion.

## License
This project is licensed under the GPL-3.0 license.
