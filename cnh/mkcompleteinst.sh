#!/bin/bash
#
# Set up a new complete instance
# 
# ** This code assumes you don't already use ~/.spack (the default spack practice) as a directory. 
#

# Parameters
SPACK_INST="v0001"

# Paramtereized paths
SPACK_BASE="/nobackup/users/${USER}/spack/${SPACK_INST}"
SPACK_SHORT="/home/${USER}/spack"
SPACK_DOT="/home/${USER}/.spack"

# Some simple checks
if [ -d ${SPACK_DOT} ]; then
 echo "ERROR: A directory exists at the location, \"${SPACK_DOT}\", specified in the SPACK_DOT variable."
 exit
fi

# 1. Create spack instance directory and links for shorter paths
##  directories
mkdir ${SPACK_BASE}
mkdir ${SPACK_BASE}/spackgit
mkdir ${SPACK_BASE}/.spack

##  links
/bin/rm ${SPACK_SHORT}
/bin/rm ${SPACK_DOT}
mkdir ${SPACK_BASE}/spackgit
mkdir ${SPACK_BASE}/.spack
ln -s ${SPACK_SHORT} ${SPACK_BASE}
ln -s ${SPACK_DOT}   ${SPACK_BASE}/.spack

echo "# Created softlinks"
echo "# \"${SPACK_SHORT}\" and \"${SPACK_DOT}\" "
echo "# that point to "
echo "# 
# 2. Check out spack
