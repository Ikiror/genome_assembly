#!/usr/bin/env bash
#SBATCH --time=6:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=meryl_counting
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_12_meryl_counting_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_12_meryl_counting_%j.e
#SBATCH --partition=pibu_el8

CONTAINER="/containers/apptainer/merqury_1.3.sif"
PACBIODATA="/data/users/aikiror/genomeAssembly/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"

WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/12_meryl_counting"
mkdir -p $OUTPUTDIR

#arabidopsisThaliana - 135MB = 135000000bp
GENOMESIZE=135000000

#k
K_INFO="${WORKDIR}/output_files/week3/11_meryl_bestk/best_k.txt"
K=$(tail -n 1 ${K_INFO})

#create meryl database
apptainer exec --bind /data/ ${CONTAINER} meryl k=${K} count ${PACBIODATA} output ${OUTPUTDIR}/pacbiodata_${K}.meryl

# #kmer evaluation
# apptainer exec --bind /data/ ${CONTAINER}