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

CONTAINER="/containers/apptainer/merqury_1.3.sif"
PACBIODATA="/data/users/aikiror/genomeAssembly/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"

WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/alt_11_meryl_counting"
mkdir -p ${OUTPUTDIR}

OUTPUT_FILE=${OUTPUTDIR}/best_k.txt

#arabidopsisThaliana - 135MB = 135000000bp
GENOMESIZE=135000000

#if path to merqury not known
#apptainer exec ${CONTAINER} find / -type f -name best_k.sh 2>/dev/null > ${OUTPUTDIR}/merqury_files.txt

BEST_K_FILEPATH=$(grep best_k.sh ${OUTPUTDIR}/merqury_files.txt | head -n 1)

#determine best_K
apptainer exec --bind /data/ ${CONTAINER} ${BEST_K_FILEPATH} ${GENOMESIZE} 0.0001 > ${OUTPUT_FILE}
