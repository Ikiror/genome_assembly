#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=lja_assembly
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_lja_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_lja_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/aikiror/genomeAssembly"
CONTAINER="/containers/apptainer/lja-0.2.sif"

PACBIODATA="${WORKDIR}/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"
OUTPUTDIR="${WORKDIR}/output_files/02_hifiasm"
HIFIASM_OUT="${OUTPUTDIR}/pacbio_hifi_Est-0"

mkdir -p $OUTPUTDIR

#generates assemblies
apptainer exec --bind /data/ ${CONTAINER} hifiasm ${PACBIODATA} -o ${HIFIASM_OUT} -t 16