#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=BUSCO_trinity
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_04_BUSCO_eval_trinity_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_04_BUSCO_eval__trinity%j.e
#SBATCH --partition=pibu_el8

#CONTAINER="/containers/apptainer/busco_5.7.1.sif"

WORKDIR="/data/users/aikiror/genomeAssembly"
TRINITYDATA="${WORKDIR}/output_files/04_trinity.Trinity.fasta"
OUTPUTDIR="${WORKDIR}/output_files/04_BUSCO_eval_trinity"
OUTPUTNAME="BUSCO_trinity_assembly"
mkdir -p $OUTPUTDIR

module load BUSCO/5.4.2-foss-2021a

busco -i ${TRINITYDATA} -m tran -l brassicales_odb10 -o ${OUTPUTNAME} --out_path ${OUTPUTDIR} 
