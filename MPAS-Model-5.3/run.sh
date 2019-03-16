#!/bin/sh
#SBATCH -J MPAS
#SBATCH --time=24:00:00
#SBATCH -o MPAS_%j.out
#SBATCH -e MPAS_%j.err
#SBATCH -p single_v100_node
#SBATCH -n 1 # total process
#SBATCH --tasks-per-node=1 # number of task in node
srun ./atmosphere_model
