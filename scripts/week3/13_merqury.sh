#!/usr/bin/env bash
#SBATCH --time=6:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=merqury
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_13_merqury_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_13_merqury_%j.e
#SBATCH --partition=pibu_el8

CONTAINER="/containers/apptainer/merqury_1.3.sif"

WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/13_merqury"
mkdir -p ${OUTPUTDIR}

OUTPUT_FIND_MERQURY_SH=${OUTPUTDIR}/merqury_file_path.txt

apptainer exec ${CONTAINER} find / -type f -name merqury.sh -print -quit > ${OUTPUTDIR}/merqury_files.txt

MERQURY_FILE_PATH=$(grep merqury.sh ${OUTPUT_FIND_MERQURY_SH} | head -n 1)