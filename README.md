Genome and Assembly Annotation

# Genome Assembly and Evaluation Pipeline — *Arabidopsis thaliana*

This repository documents a complete workflow for assembling and evaluating the Est-0 accession of the *Arabidopsis thaliana* genomes sequenced using PacBio HiFi long reads and the Sha accession of the *Arabidopsis thaliana* transcriptome sequenced using Illumina short reads. 

To replicate this workflow on your own data, download the scripts and use them in the order outlined below, or just use the relevant script for the tool desired. Adapt the scripts to your working directory, path to relevant data, path to output directories etc. 

For help with the tool and to see additional options that can be used, visit the individual tools githubs, or use "tool --help" in the command line:
    * if working with containers -> srun -p clusterPartition apptainer exec /path/to/container tool --help
    * if working with modules -> load the module and run "tool --help"

This workflow includes quality control (FASTQC, FASTP, Jellyfish, Genomescope), genome assembly (LJA, Flye, Hifiasm, Trinity) and assembly evaluation (BUSCO, QUAST, Merqury) steps. 

Quality Control:
1. FASTQC – raw data quality control  
2. FASTP – read trimming and filtering  
3. JELLYFISH – k-mer counting  
4. GENOMESCOPE – genome size and heterozygosity estimation

Genome Assembly:
1. Flye - genome assembly
2. Hifiasm - genome assembly
3. LJA - genome assembly

Assembly Evaluation:
1. TRINITY – transcriptome assembly from Illumina RNA-seq  
2. QUAST – assembly quality assessment  
3. BUSCO – completeness based on single-copy orthologs  
4. MERQURY – consensus accuracy (QV) and completeness  

## Script structure
```
scripts
--week1
----01_fastqc.sh  
----02_v1_fastp.sh  
----02_v2_fastp_for_read1_and_read2.sh  
----03_jellyfish_kmer.sh  
----04_jellyfish_histo.sh
--week2
----01_flye.sh  
----02.5_awk_hifiasm.sh  
----02_hifiasm.sh  
----03_lja_assembly.sh  
----04_trinity.sh
--week3
----01_BUSCO_eval_flye.sh
----02_BUSCO_eval_hifiasm.sh
----03_BUSCO_eval_lja.sh 
----04_BUSCO_eval_trinity.sh
----05_QUAST_flye_noref.sh
----06_QUAST_flye_ref.sh
----07_QUAST_hifiasm_noref.sh
----08_QUAST_hifiasm_ref.sh
----09_QUAST_lja_noref.sh
----10_QUAST_lja_ref.sh
----11_meryl_bestk.sh
----12_MERQURY.sh
----13_nucmer.sh
----14_mummerplot.sh
```
                 
### 🧾 Author
**Ikiror**  
MSc Bioinformatics and Computational Biology  
uniBe 