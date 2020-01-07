Chris example spack setup for Satori.

The script mkcompleteinst.sh contains commands to set up a clean Spack sub-directory
under /nobackup/users/${USER} - (set SPACK_INST vairable to specify the sub-directory).

The script then makes software links from ~/spack and ~/.spack to the sub-directory and
pulls spack from github. 

Four custom files ~/spack/spackgit/etc/spack/config.yaml, 
~/spack/spackgit/etc/spack/modules.yaml, 
~/spack/spackgit/var/spack/repos/builtin/packages/netcdf-fortran/package.py and
~/.spack/packages.yaml are added/overwritten to customize Spack install locations
and settings.

o First use

1. The file ~/.spack/packages.yaml needs some hand edits for first use. The 

     all:
        compiler: [gcc@8.3.0]

   block needs to be commented out, since gcc@8.3.0 is not installed yet.

2. Build gcc 8.3.0
   $ spack install gcc@8.3.0

3. Update compilers list
   $ spack find compilers

4. Uncomment the 

        all:
        compiler: [gcc@8.3.0]
 
   block in ~/.spack/packages.yaml.

o Subsequent use
  
  $ spack build rclone

