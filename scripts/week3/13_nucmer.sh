#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=nucmer
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_13_nucmer_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_13_nucmer_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/13_nucmer"
CONTAINER="/containers/apptainer/mummer4_gnuplot.sif"

mkdir -p $OUTPUTDIR

FLYE_OUT="flye_data"
HIFI_OUT="hifiasm_data"
LJA_OUT="lja_data"

#fasta data = diff generated genome assemblies
FLYE_ASSEMBLY="${WORKDIR}/output_files/week2/01_flye/pacbio_hifi_Est-0/assembly.fasta"
HIFI_ASSEMBLY="${WORKDIR}/output_files/week2/02_hifiasm/pacbio_hifi_Est-0.p_ctg.fa"
LJA_ASSEMBLY="${WORKDIR}/output_files/week2/03_lja/pacbio_hifi_Est-0/assembly.fasta"

REFERENCE="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

#generates a .delta file that should be able to be read by mummerplot
apptainer exec --bind /data/ ${CONTAINER} nucmer --breaklen 1000 --mincluster 1000 -p ${OUTPUTDIR}/${FLYE_OUT} ${REFERENCE} ${FLYE_ASSEMBLY}

apptainer exec --bind /data/ ${CONTAINER} nucmer --breaklen 1000 --mincluster 1000 -p ${OUTPUTDIR}/${HIFI_OUT} ${REFERENCE} ${HIFI_ASSEMBLY}

apptainer exec --bind /data/ ${CONTAINER} nucmer --breaklen 1000 --mincluster 1000 -p ${OUTPUTDIR}/${LJA_OUT} ${REFERENCE} ${LJA_ASSEMBLY}

