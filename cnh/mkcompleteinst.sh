#!/bin/bash
#
# Set up a new complete instance of Spack on Satori
# 
# ** This code assumes you don't already use ~/.spack (the default spack practice) as a directory. 
#

MY_SCRIPT_ROOT="$(cd "$(dirname "$0")"; pwd -P)"

# Parameters
SPACK_INST="v0002"
MY_NB_ROOT="/nobackup/users/${USER}"
MY_HOME=~

# For use when testing on laptop
# MY_NB_ROOT="${MY_HOME}/projects/nobackup/users/${USER}"

# Paramtereized paths
SPACK_BASE="${MY_NB_ROOT}/spack/${SPACK_INST}"
SPACK_SHORT="${MY_HOME}/spack"
SPACK_DOT="${MY_HOME}/.spack"

# Some simple checks
if [ -e ${SPACK_DOT} ] && [ ! -L ${SPACK_DOT} ] ; then
 echo "ERROR: A directory exists at the location, \"${SPACK_DOT}\", specified in the SPACK_DOT variable."
 exit
fi

# 1. Create spack instance directory and links for shorter paths
##  directories
mkdir -p ${SPACK_BASE}
mkdir -p ${SPACK_BASE}/spackgit
mkdir -p ${SPACK_BASE}/.spack

##  links
/bin/rm ${SPACK_SHORT}
/bin/rm ${SPACK_DOT}
ln -s ${SPACK_BASE} ${SPACK_SHORT}
ln -s ${SPACK_BASE}/.spack ${SPACK_DOT}

echo "# Created softlinks"
echo "# \"${SPACK_SHORT}\" and \"${SPACK_DOT}\" "
echo "# that point to "
echo "# \"${SPACK_BASE}\" and \"${SPACK_BASE}/.spack\" respectively."


# 2. Check out spack from git
cd ${SPACK_BASE}/spackgit
git clone https://github.com/spack/spack.git
cd spack
git checkout v0.13.3

# 3. Configure spack to use custom files
cd ${SPACK_BASE}/spackgit/spack
(cd  ${MY_SCRIPT_ROOT}/custom-files/spackgit/ ; tar -cvf - . ) | tar -xvf -

cd ${SPACK_BASE}/.spack
(cd  ${MY_SCRIPT_ROOT}/custom-files/.spack ; tar -cvf - . ) | tar -xvf -

# 4. Put reminder about what to do next
cat <<EOFA


###################################################################################
# OK - Spack is setup in "${SPACK_BASE}", with links from 
# "${SPACK_SHORT}".
# To start
# 1. cd ${SPACK_BASE}/spackgit/spack
#
# 2. comment out 
#
#      all:
#         compiler: [gcc@8.3.0]
#
#    in "~/.spack/package.yml"
#
# 3. bin/spack install gcc@8.3.0
# 4. bin/spack compilers find
# 5. bin/spack compilers find
# 6. restore
#
#      all:
#         compiler: [gcc@8.3.0]
#
#    in "~/.spack/package.yml"
# 7. build everything else
###################################################################################
EOFA
