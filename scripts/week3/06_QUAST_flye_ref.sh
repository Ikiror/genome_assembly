#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=QUAST_flye_ref
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_06_QUAST_flye_ref_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_06_QUAST_flye_ref_%j.e
#SBATCH --partition=pibu_el8

CONTAINER="/containers/apptainer/quast_5.2.0.sif"

WORKDIR="/data/users/aikiror/genomeAssembly"
FLYEDATA="${WORKDIR}/output_files/01_flye/pacbio_hifi_Est-0/assembly.fasta"
PACBIODATA="${WORKDIR}/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"
REFERENCE="${WORKDIR}/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

OUTPUTDIR="${WORKDIR}/output_files/06_QUAST_flye_ref"
OUTPUTNAME="QUAST_flye_assembly"

mkdir -p $OUTPUTDIR

apptainer exec --bind /data/ ${CONTAINER} quast ${FLYEDATA} -r ${REFERENCE} --eukaryote --large --pacbio ${PACBIODATA} --no-sv -o ${OUTPUTDIR}

# --eukaryote - arabidopsis thaliana is eukaryotic
# (--large) - the genome is more than 100mb
# --est-ref-size
# --threads
# --labels
# -R (-r)
# --features
# (--pacbio)
# (--no-sv)