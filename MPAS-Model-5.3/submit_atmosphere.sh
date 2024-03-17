#!/bin/bash
#SBATCH --nodes=1                #Número de Nós
#SBATCH --ntasks=8               #Numero total de tarefas MPI
#SBATCH -p sequana_gpu_shared       #Fila (partition) a ser utilizada
#SBATCH -J atmosphere_model       #Nome job
#SBATCH --time=01:20:00          #Obrigatório

executable=atmosphere_model

rm log.atmosphere.*.out

module load sequana/current
module load git/2.23_sequana
module load python/3.9.1_sequana
module load gcc/9.3_sequana
module load cmake/3.23.2_sequana

workdir=/scratch/mixprecmet/roberto.souto4
version=v0.18.1
spackdir=${workdir}/spack/${version}
. ${spackdir}/share/spack/setup-env.sh

export SPACK_USER_CONFIG_PATH=${workdir}/.spack/${version}

NVHPC_DIR=$(spack location -i nvhpc@22.3)
module load ${NVHPC_DIR}/modulefiles/nvhpc/22.3

spack load parallelio
spack load netcdf-fortran
spack load parallel-netcdf

resultdir=results/partition-${SLURM_JOB_PARTITION}/NUMNODES-$SLURM_JOB_NUM_NODES/MPI-${SLURM_NTASKS}/GPU-${dynranks}/JOBID-${SLURM_JOBID}

mkdir -p ${resultdir}

cd  $SLURM_SUBMIT_DIR

#echo "mpirun -np $SLURM_NTASKS -mca btl tcp,self,vader -mca btl_tcp_if_include ib0 --bind-to core --map-by ppr:${ppr}:L3cache ./${executable}"
#mpirun -np $SLURM_NTASKS -mca btl tcp,self,vader -mca btl_tcp_if_include ib0 --bind-to core --map-by ppr:${ppr}:L3cache ./${executable}
echo "mpirun -np $SLURM_NTASKS -mca btl tcp,self,vader -mca btl_tcp_if_include ib0 ./${executable}"
mpirun -np $SLURM_NTASKS -mca btl tcp,self,vader -mca btl_tcp_if_include ib0 ./${executable}

cp slurm-${SLURM_JOBID}.out ${resultdir}/
mv log.0000.out ${resultdir}/
mv log.0000.err ${resultdir}/
mv diag.* ${resultdir}/ 
#mv history.* ${resultdir}/ 
