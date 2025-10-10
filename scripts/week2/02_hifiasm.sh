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

#this script runs the hifiasm genome assembler on genome data

#container 
CONTAINER="/containers/apptainer/hifiasm_0.25.0.sif"

#directories
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week2/02_hifiasm"

#output prefix
HIFIASM_OUT="${OUTPUTDIR}/pacbio_hifi_Est-0"

#make outputdir path if it doesnt exist
mkdir -p $OUTPUTDIR

##est-0 data 
PACBIODATA="${WORKDIR}/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"


#generates assemblies using hifiasm assembler
apptainer exec --bind /data/ ${CONTAINER} hifiasm ${PACBIODATA} -o ${HIFIASM_OUT} -t 16

# #GFA to FASTA
#only the p_ctg.gfa to be converted
# awk '/^S/{print ">"$2;print $3}' ${HIFIASM_OUT}.gfa > ${HIFIASM_OUT}.fa