#!/usr/bin/env bash
#SBATCH --time=4:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=meryl_and_merqury
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_14_meryl_and_merqury_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_14_meryl_and_merqury_%j.e
#SBATCH --partition=pibu_el8

CONTAINER="/containers/apptainer/merqury_1.3.sif"
PACBIODATA="/data/users/aikiror/genomeAssembly/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"

WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/14_meryl_and_merqury"
mkdir -p $OUTPUTDIR

FLYE_OUT="flye_data"
HIFI_OUT="hifiasm_data"
LJA_OUT="lja_data"

#arabidopsisThaliana - 135MB = 135000000bp
GENOMESIZE=135000000

#k
K_INFO="${WORKDIR}/output_files/week3/11_meryl_bestk/best_k.txt"
K=$(tail -n 1 ${K_INFO})

export MERQURY="/usr/local/share/merqury"

#fasta data = diff generated genome assemblies
FLYE_ASSEMBLY="${WORKDIR}/output_files/01_flye/pacbio_hifi_Est-0/assembly.fasta"
HIFI_ASSEMBLY="${WORKDIR}/output_files/02_hifiasm/pacbio_hifi_Est-0.p_ctg.fa"
LJA_ASSEMBLY="${WORKDIR}/output_files/03_lja/pacbio_hifi_Est-0/assembly.fasta"


apptainer exec --bind /data/ ${CONTAINER} meryl k=${K} count ${PACBIODATA} output ${OUTPUTDIR}/pacbioEst0.meryl

cd ${OUTPUTDIR}
apptainer exec ${CONTAINER} merqury.sh pacbioEst0.meryl ${FLYE_ASSEMBLY} ${FLYE_OUT}
apptainer exec ${CONTAINER} merqury.sh pacbioEst0.meryl ${HIFI_ASSEMBLY} ${HIFI_OUT}
apptainer exec ${CONTAINER} merqury.sh pacbioEst0.meryl ${LJA_ASSEMBLY} ${LJA_OUT}

