#!/bin/bash
#SBATCH -p tsl-long                             # queue
#SBATCH -N 1                                    # number of nodes
#SBATCH --cpus-per-task=28                      # number of cpus per job
#SBATCH --mem 370GB                            # memory pool for all cores
#SBATCH -o slurm.%j.out                         # slurm job output
#SBATCH -e slurm.%j.err                         # slurm job error
#SBATCH --mail-type=begin,end,fail              # notifications for job start, end & fail
#SBATCH --mail-user=neha.sahu@tsl.ac.uk         # send-to address


source package ef83a3be-6ba6-4d26-ab03-8afff8edda5b
#"antismash - 7.0.0" ready for use


# Define input and output directories
INPUT_DIR="input"
OUTPUT_DIR="antismash_output"

# Create output directory
mkdir -p $OUTPUT_DIR

# Loop through each .fasta file in the input directory
for FASTA_FILE in $INPUT_DIR/*.fa; do
    # Extract the base name of the file (without the directory and extension)
    BASE_NAME=$(basename $FASTA_FILE .fa)
    
    # Run AntiSMASH
    antismash \
        --taxon fungi \
        $FASTA_FILE \
        --genefinding-tool glimmerhmm \
        --fullhmmer \
        --tigrfam \
        --cc-mibig \
        --asf \
        --cb-general \
        --cb-subclusters \
        --cb-knownclusters \
        --pfam2go \
        --rre \
        --smcog-trees \
        --tfbs \
        --output-dir $OUTPUT_DIR/$BASE_NAME \
        --cpus 28
done
