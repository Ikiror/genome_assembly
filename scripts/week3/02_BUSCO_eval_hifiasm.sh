#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=BUSCO_hifiasm
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_02_BUSCO_eval_hifiasm_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_02_BUSCO_eval__hifiasm%j.e
#SBATCH --partition=pibu_el8

#CONTAINER="/containers/apptainer/busco_5.7.1.sif"

WORKDIR="/data/users/aikiror/genomeAssembly"
HIFIASMDATA="${WORKDIR}/output_files/02_hifiasm/pacbio_hifi_Est-0.p_ctg.fa"
OUTPUTDIR="${WORKDIR}/output_files/02_BUSCO_eval_hifiasm"
OUTPUTNAME="BUSCO_hifiasm_assembly"
mkdir -p $OUTPUTDIR

module load BUSCO/5.4.2-foss-2021a

busco -i ${HIFIASMDATA} -m geno -l brassicales_odb10 -o ${OUTPUTNAME} --out_path ${OUTPUTDIR} 
