#!/usr/bin/env bash

name="gpt4all-base"
def_file=$(realpath "$name.def")
sif_file=$(realpath "$name.sif")

pushd ..

./_singularity_build.sh $sif_file $def_file

popd

