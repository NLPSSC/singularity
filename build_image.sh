#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

image_name="${1%/}"

sif_file="$(realpath "./$image_name/$image_name.sif")"
def_file="$(realpath "./$image_name/$image_name.def")"

[[ -f ${def_file} ]] && def_file_exists="1" || def_file_exists="0"
[[ -f ${sif_file} ]] && sif_file_exists="1" || sif_file_exists="0"

# echo "def_file_exists: $def_file_exists"
# echo "sif_file_exists: $sif_file_exists"

# --section post
# DISABLE_CACHE="--disable-cache"
# section_start="--section $SINGULARITY_SECTION"
BUILD_HOW="--remote"
DO_DEBUG=""  # "-d" # to set
DISABLE_CACHE=""
GPU="--nv"
FORCE="--force"
SANDBOX="--sandbox"

if [ "$sif_file_exists" = "1" ]; then
    SANDBOX="$SANDBOX --update"
fi

[[ ! -z "$SANDBOX" ]] && sif_file="${sif_file%.*}"

SWITCHES="${GPU} ${DISABLE_CACHE} ${FORCE} ${SANDBOX} "

cmd="singularity ${DO_DEBUG} build ${SWITCHES} ${sif_file} ${def_file}"
# sudo singularity build --nv --force /home/westerd/data/singularity/conda-base/conda-base.sif /home/westerd/data/singularity/conda-base/conda-base.def
eval $cmd

echo $cmd

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#
# Test Code
#
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
# cmd_array=()
# cmd_array+="${GPU}"
# cmd_array+="${DISABLE_CACHE}"
# cmd_array+="${FORCE}"
# cmd_array+="${SANDBOX}"
# cmd_array+="${sif_file}"
# cmd_array+="${def_file}"

# IFS="|$IFS";printf "%s\\n" "${cmd_array[*]}"; IFS="${IFS:1}"
# printf -v SWITCHES '%s %s %s %s' "${GPU}" "${DISABLE_CACHE}" "${FORCE}" "${SANDBOX}"

# printf -v cmd 'singularity build %s %s %s' "${SWITCHES}" "${sif_file}" "${def_file}"
# sudo singularity build --nv --force /home/westerd/data/singularity/conda-base/conda-base.sif /home/westerd/data/singularity/conda-base/conda-base.def
# eval $cmd

# echo $cmd