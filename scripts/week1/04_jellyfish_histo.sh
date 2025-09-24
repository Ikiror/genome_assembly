#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=jellyfish_histo
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_jellyfish_histo_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_jellyfish_histo_%j.e
#SBATCH --partition=pibu_el8

CONTAINER="/containers/apptainer/jellyfish:2.2.6--0"

WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/04_jellyfish_histo"
JFFILE="${WORKDIR}/output_files/03_jellyfish_kmer/genome_data_reads.jf"

mkdir -p ${OUTPUTDIR}

module load Jellyfish/2.3.0-GCC-10.3.0

jellyfish histo -t 4 ${JFFILE} > ${OUTPUTDIR}/genome_data_reads.histo