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

#this script runs the lja genome assembler on genome data 

#container
CONTAINER="/containers/apptainer/lja-0.2.sif"

#directories
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week2/03_lja/pacbio_hifi_Est-0"

#make outputdir path if it doenst exist
mkdir -p $OUTPUTDIR

#est-0 data 
PACBIODATA="${WORKDIR}/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"


#generates assemblies
apptainer exec --bind /data/ ${CONTAINER} lja --output-dir ${OUTPUTDIR} --reads ${PACBIODATA}