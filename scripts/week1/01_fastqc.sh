#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_fastqc_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

CONTAINER="/containers/apptainer/fastqc-0.12.1.sif"
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/01_fastqc"
GENOMEDATAFOLDER="${WORKDIR}/genome_data/Est-0"
ASCENSCIONFOLDER="${WORKDIR}/ascension_data/RNAseq_Sha"

mkdir -p ${OUTPUTDIR}

apptainer exec --bind /data/ ${CONTAINER} fastqc ${GENOMEDATAFOLDER}/*.gz ${ASCENSCIONFOLDER}/*gz --outdir ${OUTPUTDIR} 
