#!/usr/bin/env bash

set -Eeuo pipefail

#######################################################################
# conda environment
#######################################################################

__conda_setup="$('conda' 'shell.bash' 'hook' 2> /dev/null)"
eval "$__conda_setup"
unset __conda_setup

#######################################################################
# software
#######################################################################

export SPIRED_DIR=$(dirname $(realpath $0))

#######################################################################
# pasre parameters
#######################################################################

help() {
    echo -e "Usage:\n"
    echo -e "bash run_spired.sh [-i INPUT] [-m MODEL_DIR] [-o FOLDER] [-d DEVICE]\n"
    echo -e "Description:\n"
    echo -e " \e[1;31m-i\e[0m input the fasta file (e.g. -i ./example_spired/test.fasta)"
    echo -e " \e[1;31m-m\e[0m model directory (e.g. -m ./model)"
    echo -e " \e[1;31m-o\e[0m output folder (e.g. -o example_spired)"
    echo -e " \e[1;31m-d\e[0m device for inference (e.g. -d cpu or -d cuda:0, default: cpu)"
    echo -e "\e[1;31mAll parameters must be set!\e[0m"
    exit 1
}

device=cpu

# check the validity of parameters
while getopts 'i:m:o:d:' PARAMETER
do
    case ${PARAMETER} in
        i)
        input=${OPTARG};;
        m)
        model_dir=$(realpath -e ${OPTARG});;
        o)
        folder=$(realpath -e ${OPTARG});;
        d)
        device=${OPTARG};;
        ?)
        help;;
    esac
done

shift "$(($OPTIND - 1))"

if [ -z "${input:-}" ] || [ -z "${model_dir:-}" ] || [ -z "${folder:-}" ]; then
    echo -e "\e[1;31mMissing required parameters!\e[0m"
    help
fi

#######################################################################
# run SPIRED
#######################################################################

echo -e "Input fasta file: \e[1;31m${input}\e[0m"
echo -e "Model directory: \e[1;31m${model_dir}\e[0m"
echo -e "Output folder: \e[1;31m${folder}\e[0m"
echo -e "Device: \e[1;31m${device}\e[0m"

# predict Cα protein structure
conda activate spired
# conda activate spired_fitness
python ${SPIRED_DIR}/run_SPIRED.py --fasta_file ${input} --model_dir ${model_dir} --saved_folder ${folder} --device ${device}

# predict full-atom protein structure by GDFold2
# conda activate gdfold2
python ${SPIRED_DIR}/scripts/GDFold2/fold.py ${input} ${folder} -d ${device}
python ${SPIRED_DIR}/scripts/GDFold2/relax.py --input ${input} --output ${folder}
