#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_flye_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_flye_%j.e
#SBATCH --partition=pibu_el8

#this script runs the flye genome assembler on genome data 

#container
CONTAINER="/containers/apptainer/flye_2.9.5.sif"

#directories
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week2/01_flye"

#output prefix
FLYE_OUT="${OUTPUTDIR}/pacbio_hifi_Est-0"

#make outputdir path if it doenst exist
mkdir -p $OUTPUTDIR

#est-0 data 
PACBIODATA="${WORKDIR}/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"

#run flye assembler
apptainer exec --bind /data/ ${CONTAINER} flye --pacbio-hifi ${PACBIODATA} --out-dir ${FLYE_OUT} --threads 16
