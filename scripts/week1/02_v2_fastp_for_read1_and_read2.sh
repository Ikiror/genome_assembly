#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp_v2
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_fastp_v2_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_fastp_v2_%j.e
#SBATCH --partition=pibu_el8

CONTAINER="/containers/apptainer/fastp_0.23.2--h5f740d0_3.sif"
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/02_fastp"

mkdir -p ${OUTPUTDIR}

READ1="${WORKDIR}/ascension_data/RNAseq_Sha/ERR754081_1.fastq.gz"
READ2="${WORKDIR}/ascension_data/RNAseq_Sha/ERR754081_2.fastq.gz"


apptainer exec --bind /data/ ${CONTAINER} fastp -i ${READ1} -I ${READ2} -o ${OUTPUTDIR}/ascension_read_1.fastq.gz -O ${OUTPUTDIR}/ascension_read_2.fastq.gz -h "${OUTPUTDIR}/ascension_data_fastp.html"
