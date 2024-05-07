{
  description = "LFS Development Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
    };
  in with pkgs;
  {
    devShells.${system}.default = mkShell {
      preShellHook = ''
      '';

      packages = [
        bash
        binutils
        bison
        coreutils
        diffutils
        findutils
        gawk
        gcc
        gnugrep
        gnum4
        gnumake
        gnupatch
        gnused
        gnutar
        gzip
        linux
        perl
        python3
        texinfo
        xz
      ];

      shellHook = ''
        set +h
        umask 022

        LFS=/mnt/lfs
        LC_ALL=POSIX
        LFS_TGT=$(uname -m)-lfs-linux-gnu
        CONFIG_SITE=$LFS/usr/share/config.site

        PATH=$PATH:/usr/bin
        if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
        PATH=$LFS/tools/bin:$PATH

        export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
        export LD_LIBRARY_PATH=${pkgs.gcc}/lib/
      '';
    };
  };
}
