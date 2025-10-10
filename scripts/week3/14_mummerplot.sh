#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=mummerplot
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/aikiror/genomeAssembly/report_and_errors/output_14_mummerplot_%j.o
#SBATCH --error=/data/users/aikiror/genomeAssembly/report_and_errors/error_14_mummerplot_%j.e
#SBATCH --partition=pibu_el8

#this script uses already generated .delta and plots the alignemnt of reference vs the query(assembly) using mummerplot

#directories
WORKDIR="/data/users/aikiror/genomeAssembly"
OUTPUTDIR="${WORKDIR}/output_files/week3/14_mummerplot"
CONTAINER="/containers/apptainer/mummer4_gnuplot.sif"

#make outputdir path if it doesnt exist
mkdir -p ${OUTPUTDIR}

#fasta data = diff generated genome assemblies
FLYE_ASSEMBLY="${WORKDIR}/output_files/week2/01_flye/pacbio_hifi_Est-0/assembly.fasta"
HIFI_ASSEMBLY="${WORKDIR}/output_files/week2/02_hifiasm/pacbio_hifi_Est-0.p_ctg.fa"
LJA_ASSEMBLY="${WORKDIR}/output_files/week2/03_lja/pacbio_hifi_Est-0/assembly.fasta"

#reference fasta for comparison
REFERENCE="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

#output prefix
FLYE_OUT="flye_data"
HIFI_OUT="hifiasm_data"
LJA_OUT="lja_data"

#assembly delta paths
FLYEDELTA="${WORKDIR}/output_files/week3/15_nucmer/flye_data.delta"
HIFIDELTA="${WORKDIR}/output_files/week3/15_nucmer/hifiasm_data.delta"
LJADELTA="${WORKDIR}/output_files/week3/15_nucmer/lja_data.delta"

#plotting
apptainer exec --bind /data/ ${CONTAINER} mummerplot -t png --layout --filter --large --fat -R ${REFERENCE} -Q ${FLYE_ASSEMBLY} -p ${OUTPUTDIR}/${FLYE_OUT} ${FLYEDELTA}

apptainer exec --bind /data/ ${CONTAINER} mummerplot -t png --layout --filter --large --fat -R ${REFERENCE} -Q ${HIFI_ASSEMBLY} -p ${OUTPUTDIR}/${HIFI_OUT} ${HIFIDELTA}

apptainer exec --bind /data/ ${CONTAINER} mummerplot -t png --layout --filter --large --fat -R ${REFERENCE} -Q ${LJA_ASSEMBLY} -p ${OUTPUTDIR}/${LJA_OUT} ${LJADELTA}

# Mummerplot:

# -R +
# -Q +
# --filter +
# -t png +
# --large +
# --layout +
# --fat