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
OUTPUTDIR="${WORKDIR}/output_files/03_jellyfish_kmer"

mkdir -p ${OUTPUTDIR}

jellyfish count \
[OPTIONS] \
<(zcat myreads.fastq.gz) \
<(zcat myotherreads.fastq.gz)

apptainer --bind /data/ ${CONTAINER} jellyfish histo