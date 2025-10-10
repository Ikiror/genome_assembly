#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=BUSCO_flye
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_01_BUSCO_eval_flye_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_01_BUSCO_eval__flye%j.e
#SBATCH --partition=pibu_el8

#CONTAINER="/containers/apptainer/busco_5.7.1.sif"

#directories
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/01_BUSCO_eval_flye"
OUTPUTNAME="BUSCO_flye_assembly"

#make outputdir path if it doesnt exist
mkdir -p $OUTPUTDIR

#assembly fasta 
FLYEDATA="${WORKDIR}/output_files/week2/01_flye/pacbio_hifi_Est-0/assembly.fasta"


#load module
module load BUSCO/5.4.2-foss-2021a

#run busco
busco -i ${FLYEDATA} -m geno -l brassicales_odb10 -o ${OUTPUTNAME} --out_path ${OUTPUTDIR} 
