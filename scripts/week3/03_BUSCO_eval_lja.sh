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

#CONTAINER="/containers/apptainer/busco_5.7.1.sif"

WORKDIR="/data/users/aikiror/genomeAssembly"
LJADATA="${WORKDIR}/output_files/03_lja/pacbio_hifi_Est-0/assembly.fasta"
OUTPUTDIR="${WORKDIR}/output_files/03_BUSCO_eval_lja"
OUTPUTNAME="BUSCO_lja_assembly"
mkdir -p $OUTPUTDIR

module load BUSCO/5.4.2-foss-2021a

busco -i ${LJADATA} -m geno -l brassicales_odb10 -o ${OUTPUTNAME} --out_path ${OUTPUTDIR} 
