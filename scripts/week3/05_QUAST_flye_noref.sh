#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=QUAST_flye_noref
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_05_QUAST_flye_noref_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_05_QUAST_flye_noref_%j.e
#SBATCH --partition=pibu_el8

#this script runs QUAST on an assembly to infer several quality metrics for evaluation and comparison of assemblies
#without reference

#container
CONTAINER="/containers/apptainer/quast_5.2.0.sif"

#directories
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/05_QUAST_flye_noref"
OUTPUTNAME="QUAST_flye_assembly_noref"

#make outputdir path if it doesnt exist
mkdir -p $OUTPUTDIR

#assembly data
FLYEDATA="${WORKDIR}/output_files/week2/01_flye/pacbio_hifi_Est-0/assembly.fasta"

#pacbio data
PACBIODATA="${WORKDIR}/PacBio_genome_data/Est-0/ERR11437308.fastq.gz"


#runs quast on flye assembly without a reference
apptainer exec --bind /data/ ${CONTAINER} quast ${FLYEDATA} --eukaryote --large --pacbio ${PACBIODATA} --no-sv -o ${OUTPUTDIR}

# --eukaryote - arabidopsis thaliana is eukaryotic
# (--large) - the genome is more than 100mb
# --est-ref-size
# --threads
# --labels
# -R (-r)
# --features
# (--pacbio)
# (--no-sv)