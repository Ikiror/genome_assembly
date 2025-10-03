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
OUTPUTDIR="${WORKDIR}/output_files/02_hifiasm"
HIFIASM_OUT="${OUTPUTDIR}/pacbio_hifi_Est-0"

mkdir -p $OUTPUTDIR

# #GFA to FASTA
#only the p_ctg.gfa to be converted
awk '/^S/{print ">"$2;print $3}' ${HIFIASM_OUT}.bp.p_ctg.gfa > ${HIFIASM_OUT}.p_ctg.fa