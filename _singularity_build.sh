#!/usr/bin/bash

name="$1"
singularity build --remote "$name.sif" "$name.def"