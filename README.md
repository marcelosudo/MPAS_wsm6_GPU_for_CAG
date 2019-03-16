# MPAS_wsm6_GPU_for_CAG
This repository was made for reviewing process of Computers and Geosciences journal.
It consists of GPU Acceleration of MPAS WSM6 and MPAS orginal CPU code.
MPAS-GPU-for_wsm6 is GPU Acceleration code of MPAS WSM6, and MPAS-Model-5.3 is original CPU codes.

These codes require some librarys. The required software are PGI compiler, HDF5, Parallel NETCDF, NETCDF, and PIO.

you can compile atmosphere and init_atmosphere below instruction.
make pgi CORE=atmosphere \
make clean CORE=init_atmosphere \
make pgi CORE=init_atmosphere

Unfortunately, we cannot upload initial data on github due to their size.
Thus, you should prepare initial data on your way.
You can refer the MPAS homepage for preparing initial data (https://mpas-dev.github.io/atmosphere/real_data.html).
