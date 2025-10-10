#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=jellyfish_kmer
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_jellyfish_kmer_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_jellyfish_kmer_%j.e
#SBATCH --partition=pibu_el8

#this script runs jellyfish to perform kmer counting

#container
CONTAINER="/containers/apptainer/jellyfish:2.2.6--0"

#directories
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/03_jellyfish_kmer"

#make outputdir path if it doesnt exist
mkdir -p ${OUTPUTDIR}

#trimmed est-0 data
FASTQFILES="${WORKDIR}/output_files/02_fastp/genome_data.fastq.gz"


#load module
module load Jellyfish/2.3.0-GCC-10.3.0

# apptainer --bind /data/ ${CONTAINER} jellyfish count \
# [-C -m 21 -s 5G -t 4 ${FASTQFILES} -o genome_data_reads.jf] \
# <(zcat ${FASTQFILES})

#run jellyfish count
jellyfish count -C -m 21 -s 5G -t 4 -o ${OUTPUTDIR}/genome_data_reads.jf <(zcat ${FASTQFILES})