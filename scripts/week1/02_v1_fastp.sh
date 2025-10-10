#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp_v1
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_fastp_v1_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_fastp_v1_%j.e
#SBATCH --partition=pibu_el8

#this script runs fastp to trim and improve quality of data

#container
CONTAINER="/containers/apptainer/fastp_0.23.2--h5f740d0_3.sif"

#directories 
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/02_fastp"

#make outputdir path if it doesnt exist
mkdir -p ${OUTPUTDIR}

#est-0 accession data
GENOMEDATA="${WORKDIR}/genome_data/Est-0/ERR11437308.fastq.gz"


#run fastp
apptainer exec --bind /data/ ${CONTAINER} fastp --in1 ${GENOMEDATA} --out1 "${OUTPUTDIR}/genome_data.fastq.gz" -Q -h "${OUTPUTDIR}/genome_data_fastp.html"
