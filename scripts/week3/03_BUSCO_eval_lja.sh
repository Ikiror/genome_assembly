#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=BUSCO_lja
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_03_BUSCO_eval_lja_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_03_BUSCO_eval__lja%j.e
#SBATCH --partition=pibu_el8

#this script runs busco to evaluate the assembly

#CONTAINER="/containers/apptainer/busco_5.7.1.sif"

#directories
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/03_BUSCO_eval_lja"
OUTPUTNAME="BUSCO_lja_assembly"

#make outputdir path if it doesnt exist
mkdir -p $OUTPUTDIR

#assembly fasta
LJADATA="${WORKDIR}/output_files/week2/03_lja/pacbio_hifi_Est-0/assembly.fasta"

#load module
module load BUSCO/5.4.2-foss-2021a

#run busco
busco -i ${LJADATA} -m geno -l brassicales_odb10 -o ${OUTPUTNAME} --out_path ${OUTPUTDIR} 
