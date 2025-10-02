# SeQUencIng and antimicrobial Resistance epidemiology Linkage (SQUIRL) : A simple desktop application for genome assembly of short and long read data
[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-24.10.3-23aa62.svg)](https://www.nextflow.io/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)


![image](https://github.com/user-attachments/assets/1e85c53a-f530-4236-b162-93a264a5dc5a)
![image](https://www.oucru.org/wp-content/uploads/2023/02/cropped-cropped-oucru-logo-e1676437479194-150x113.png)![image](https://www.pathogensurveillance.net/wp-content/uploads/2022/05/cgps-32.png)

## Overview

ACORN (A Clinically Oriented Antimicrobial Resistance Surveillance Network) is a large-scale, prospective, case-based AMR surveillance initiative conducted across nine low- and middle-income countries in Africa and Asia. A whole genome sequencing (WGS) component was incorporated, to sequence 200 isolates per country.

On-site whole genome sequencing faced multiple challenges, including constraints in supply chain logistics, reagent and consumable distribution and availability, cost fluctuations, and limitations in local bioinformatics infrastructure. Here, we want to address the last problem with a simple desktop application for long- and short-read genomic data; allowing standardised, easily accessible assembly to be distributed across multiple sentinel sites without the need for local bioinformatics.

This repository contains the hybrid assembly pipeline which is designed for assembling genomic data based on a provided samplesheet. The pipeline supports different assemblers depending on the type of sequencing reads provided. 

The containerlised app and GUI can be downloaded [here](https://oucruaap-my.sharepoint.com/:f:/g/personal/tungts_oucru_org/EkI45Tv6kzJAv7lSh6udrqgBCcyk_RvQp5DZQGdK18sMpg?e=5ooOEG) and full [installation instruction](https://tungstrinh.github.io/squirls-assembler-protocol/).

This work is funded by [ACORN network](https://acornamr.net/#/), a collaboration between [Oxford University Clinical Research Unit - Hanoi (OUCRU-HN)](https://www.oucru.org/location/oucru-ha-noi/) and [Centre for Genomic Pathogen Surveillance (CGPS)](https://www.pathogensurveillance.net/).


### Authors
 - Trinh Son Tung           @tungstrinh       <tungts@oucru.org>
 - Julio Diaz Caballero     @juliofdiaz       <julio.diaz@cgps.group>  
 - Pranit Shinde            @parnit1          <pranit.shinde@cgps.group>
 - Nabil-Fareed Alikhan     @happykhan        <nabil.alikhan@cgps.group>


## Assemblers

- **Short Reads Only**: Assembled using **Shovill**.
- **Long Reads Only**: Assembled using **Dragonflye**.
- **Both Long and Short Reads**: Assembled using **Unicycler**.

### Install 
Clone the repository
```
git clone   https://github.com/cgps-discovery/GHRU-assembly.git
```
or 

Download and unzip/extract the latest release.

# Parameters
## Input/output options

Define where the pipeline should find input data and save output data.

| Parameter | Description | Type | Default | Required | Hidden |
|-----------|-------------|------|---------|----------|--------|
| `samplesheet` | Input sample sheet, as csv file | `string` | ${launchDir}/samplesheet.csv |  |  |
| `outdir` | The output directory where the results will be saved. You have to use absolute paths to storage on Cloud infrastructure. | `string` | ${launchDir}/output |  |  |

## Other parameters

| Parameter | Description | Type | Default | Required | Hidden |
|-----------|-------------|------|---------|----------|--------|
| `max_memory` | Maximum memory to use for each process | `string` | 16.GB |  | True |
| `max_cpus` | Maximum number of CPUs to use for each process | `integer` | 10 |  | True |
| `max_time` | Maximum time to use for each process | `string` | 10.h |  | True |
| `adapter_file` | Adapter file for trimming | `string` | ${projectDir}/data/adapters.fasta |  | True |
| `min_contig_length` | Minimum contig length to keep | `integer` | 500 |  | True |
| `medaka_model` | Medaka model to use | `string` | r941_e81_fast_g514 |  | True |


## Example Command

To run the pipeline with the `samplesheet` and `output` path, use:

```bash
nextflow run main.nf --samplesheet /path/to/samplesheet.csv --outdir /path/to/output
```

## Usage
1. Prepare the Samplesheet: Ensure your CSV samplesheet contains the necessary fields for your samples. The required format is as follows:

```bash
sample_id,short_reads1,short_reads2,long_reads,genome_size
```
An example sample sheet has been provided in the project directory

2. Run the Pipeline: Execute the Nextflow command with the appropriate arguments:
```bash
nextflow run main.nf --samplesheet test_input/samplesheet.csv -resume
```

## Requirements
### Software
    - The pipeline is primarily built for Linux operating systems (e.g., Linux, Windows with [WSL](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux)).
    - Currently, hybrid assembly and long-read assembly are not supported on macOS due to compatibility issues with Medaka on some macOS versions and MacBook models.
    - Nextflow version 24 or higher is required.
    - Docker must be running, with 10 cores and 16GB RAM allocated in Docker Desktop if using Windows WSL.
### Hardware 
It is recommended to have at least 10 cores and 16GB of RAM and 50GB of free storage


# Troubleshooting
    - File Not Found Errors: Ensure that all specified file paths (samplesheet, output directory, medaka model, adapter file) are correct and accessible.
    - Permission Issues: Verify that you have the necessary permissions to read the input files and write to the output directory.


