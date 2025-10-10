#!/usr/bin/env bash
#SBATCH --time=4:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=best_k
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_11_meryl_bestk_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_11_meryl_bestk_%j.e
#SBATCH --partition=pibu_el8

#this script calculates the best k to use when not sure which k-mer size to use

#path to container
CONTAINER="/containers/apptainer/merqury_1.3.sif"

#directories
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/11_meryl_bestk"

#make outputdir path if it doesnt exist
mkdir -p ${OUTPUTDIR}

#output prefix
OUTPUT_FILE=${OUTPUTDIR}/best_k.txt

#arabidopsisThaliana genome size- 135MB = 135000000bp
GENOMESIZE=135000000

#if path to merqury not known
#apptainer exec ${CONTAINER} find / -type f -name best_k.sh 2>/dev/null > ${OUTPUTDIR}/merqury_files.txt

#path to best_k.sh script
BEST_K_FILEPATH=$(grep best_k.sh ${OUTPUTDIR}/merqury_files.txt | head -n 1)

#determine best_K
apptainer exec --bind /data/ ${CONTAINER} ${BEST_K_FILEPATH} ${GENOMESIZE} 0.0001 > ${OUTPUT_FILE}
