#!/usr/bin/env bash

SINGULARITY="$(which singularity)"
DO_DEBUG="" # "-d" to set

sif_file="$1"
def_file="$2"

BUILD_HOW="--remote"
ELEVATED_PERMS=""
if [[ "$LOCAL_SINGULARITY_BUILD"="1" ]]; then
    BUILD_HOW=""
    ELEVATED_PERMS="sudo"
fi

singularity build --force --section post "$sif_file" "$def_file" 
