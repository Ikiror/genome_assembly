#!/usr/bin/env bash
#SBATCH --time=6:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=merqury
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_13_merqury_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_13_merqury_%j.e
#SBATCH --partition=pibu_el8

#container
CONTAINER="/containers/apptainer/merqury_1.3.sif"

#directory paths and setup
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/13_merqury"
mkdir -p ${OUTPUTDIR}
FLYE_OUT="${OUTPUTDIR}/flye_data"
HIFI_OUT="${OUTPUTDIR}/hifiasm_data"
LJA_OUT="${OUTPUTDIR}/lja_data"

mkdir -p ${FLYE_OUT} ${HIFI_OUT} ${LJA_OUT}

#relevant data
MERYL_DATA="${WORKDIR}/output_files/week3/12_meryl_counting/pacbiodata_20.148.meryl/"

#fasta data = diff generated genome assemblies
FLYE_ASSEMBLY="${WORKDIR}/output_files/01_flye/pacbio_hifi_Est-0/assembly.fasta"
HIFI_ASSEMBLY="${WORKDIR}/output_files/02_hifiasm/pacbio_hifi_Est-0.p_ctg.fa"
LJA_ASSEMBLY="${WORKDIR}/output_files/03_lja/pacbio_hifi_Est-0/assembly.fasta"

#file with identified file path 
OUTPUT_FIND_MERQURY_SH=${OUTPUTDIR}/merqury_file_path.txt

#identifying file path if path not known
# apptainer exec ${CONTAINER} find / -type f -name merqury.sh -print -quit > ${OUTPUT_FIND_MERQURY_SH}

#getting result of file path identification
MERQURY_FILE_PATH=$(grep merqury.sh ${OUTPUT_FIND_MERQURY_SH} | head -n 1)

#merqury run
echo "Running Merqury on flye data..."
cd ${FLYE_OUT}
apptainer exec --bind /data/ ${CONTAINER} bash -c "export MERQURY=/usr/local/share/merqury/; ${MERQURY_FILE_PATH} ${MERYL_DATA} ${FLYE_ASSEMBLY} flye_data"

echo "Running Merqury on hifiasm data..."
cd ${HIFI_OUT}
apptainer exec --bind /data/ ${CONTAINER} bash -c "export MERQURY=/usr/local/share/merqury/; ${MERQURY_FILE_PATH} ${MERYL_DATA} ${HIFI_ASSEMBLY} hifiasm_data"

echo "Running Merqury on lja data..."
cd ${LJA_OUT}
apptainer exec --bind /data/ ${CONTAINER} bash -c "export MERQURY=/usr/local/share/merqury/; ${MERQURY_FILE_PATH} ${MERYL_DATA} ${LJA_ASSEMBLY} lja_data"


