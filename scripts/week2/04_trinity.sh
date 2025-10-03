#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=trinity
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_trinity_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_trinity_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/aikiror/genomeAssembly"
RNADATA="${WORKDIR}/Illumina_ascension_data/RNAseq_Sha"
OUTPUTDIR="${WORKDIR}/output_files/04_trinity"

READ1="${RNADATA}/ERR754081_1.fastq.gz"
READ2="${RNADATA}/ERR754081_2.fastq.gz"

mkdir -p $OUTPUTDIR

module load Trinity/2.15.1-foss-2021a

Trinity --seqType fq --left ${READ1} --right ${READ2} --CPU 16 --max_memory 64G --output ${OUTPUTDIR}