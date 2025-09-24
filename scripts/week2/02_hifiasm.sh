#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=hifiasm
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_hifiasm_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/aikiror/genomeAssembly"
CONTAINER="/containers/apptainer/hifiasm_0.25.0.sif"
PACBIODATA="${WORKDIR}/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"
OUTPUTDIR="${WORKDIR}/output_files/02_hifiasm"
HIFIASM_OUT="${OUTPUTDIR}/pacbio_hifi_Est-0"

mkdir -p $OUTPUTDIR

#generates assemblies
apptainer exec --bind /data/ ${CONTAINER} hifiasm ${PACBIODATA} -o ${HIFIASM_OUT} -t 16

# #GFA to FASTA
# awk '/^S/{print ">"$2;print $3}' ${HIFIASM_OUT}.gfa > ${HIFIASM_OUT}.fa