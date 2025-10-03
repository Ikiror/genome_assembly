#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=meryl_counting
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_11_meryl_counting_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_11_meryl_counting_%j.e
#SBATCH --partition=pibu_el8

CONTAINER="/containers/apptainer/merqury_1.3.sif"
PACBIODATA="/data/users/aikiror/genomeAssembly/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"

WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/11_meryl_counting"
mkdir -p $OUTPUTDIR

#arabidopsisThaliana - 135MB = 135000000bp
GENOMESIZE=135000000
#k recommended by the documentation
K=21

#create meryl database
apptainer exec --bind /data/ ${CONTAINER} meryl k=${K} count ${PACBIODATA} output ${OUTPUTDIR}/pacbiodata.meryl

# #kmer evaluation
# apptainer exec --bind /data/ ${CONTAINER}