#!/usr/bin/env bash
#SBATCH --time=6:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=MERQURY
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_12_MERQURY_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_12_MERQURY_%j.e
#SBATCH --partition=pibu_el8

#container
CONTAINER="/containers/apptainer/merqury_1.3.sif"

#directories; outputs
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/12_MERQURY"
mkdir -p ${OUTPUTDIR}

#pacbio hifi reads
PACBIODATA="${WORKDIR}/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"

#arabidopsisThaliana - 135MB = 135000000bp
GENOMESIZE=135000000

#previously determined k
K_INFO="${WORKDIR}/output_files/week3/11_meryl_bestk/best_k.txt"
K=$(tail -n 1 ${K_INFO})
echo "Using k = ${K}"

#fasta data = diff generated genome assemblies
FLYE_ASSEMBLY="${WORKDIR}/output_files/week2/01_flye/pacbio_hifi_Est-0/assembly.fasta"
HIFI_ASSEMBLY="${WORKDIR}/output_files/week2/02_hifiasm/pacbio_hifi_Est-0.p_ctg.fa"
LJA_ASSEMBLY="${WORKDIR}/output_files/week2/03_lja/pacbio_hifi_Est-0/assembly.fasta"

#output subdirectories
FLYE_OUT="flye_data"
HIFI_OUT="hifiasm_data"
LJA_OUT="lja_data"

###
#meryl kmer database from pacbio hifi reads
echo "*** Building meryl database from PacBio reads ***"
cd ${OUTPUTDIR}

# Run meryl inside the container (k determined from earlier step)
# This generates pacbioEst0.meryl directory containing k-mer counts
apptainer exec --bind /data/ ${CONTAINER} meryl count k=${K} output pacbioEst0.meryl ${PACBIODATA}

echo "Meryl database built: ${OUTPUTDIR}/pacbioEst0.meryl"

###
#merqury run on each genome

# Export Merqury installation path (inside container)
export MERQURY="/usr/local/share/merqury"

#echo to check if script running
echo "=== Running Merqury for Flye assembly ==="
apptainer exec --bind /data/ ${CONTAINER} merqury.sh pacbioEst0.meryl ${FLYE_ASSEMBLY} ${FLYE_OUT}

#echo to check if script running
echo "=== Running Merqury for Hifiasm assembly ==="
apptainer exec --bind /data/ ${CONTAINER} merqury.sh pacbioEst0.meryl ${HIFI_ASSEMBLY} ${HIFI_OUT}

#echo to check if script running
echo "=== Running Merqury for LJA assembly ==="
apptainer exec --bind /data/ ${CONTAINER} merqury.sh pacbioEst0.meryl ${LJA_ASSEMBLY} ${LJA_OUT}

#echo to check if script running
echo "Merqury evaluations complete!"
echo "Check the output folders in: ${OUTPUTDIR}/"