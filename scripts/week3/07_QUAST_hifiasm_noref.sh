#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=QUAST_hifiasm_noref
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_07_QUAST_hifiasm_noref_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_07_QUAST_hifiasm_noref_%j.e
#SBATCH --partition=pibu_el8

CONTAINER="/containers/apptainer/quast_5.2.0.sif"

WORKDIR="/data/users/aikiror/genomeAssembly"
HIFIASMDATA="${WORKDIR}/output_files/02_hifiasm/pacbio_hifi_Est-0.p_ctg.fa"
OUTPUTDIR="${WORKDIR}/output_files/07_QUAST_hifiasm_noref"
PACBIODATA="${WORKDIR}/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"

mkdir -p $OUTPUTDIR

apptainer exec --bind /data/ ${CONTAINER} quast ${HIFIASMDATA} --eukaryote --large --pacbio ${PACBIODATA} --no-sv -o ${OUTPUTDIR}

# --eukaryote - arabidopsis thaliana is eukaryotic
# (--large) - the genome is more than 100mb
# --est-ref-size
# --threads
# --labels
# -R (-r)
# --features
# (--pacbio)
# (--no-sv)