with import <nixpkgs> {}; {
     pyEnv = stdenv.mkDerivation {
       name = "mutt";
       buildInputs = [
            stdenv
            python27Full
            mutt
            vimEnv
            python27Packages.goobook

      ];
      pathsToLink = [ "/include" "/lib" ];
      shellHook = ''
        export LIBRARY_PATH=/var/run/current-system/sw/lib;
        export C_INCLUDE_PATH=/var/run/current-system/sw/include;
        export LD_LIBRARY_PATH=/var/run/current-system/sw/lib;
        export PATH=$PATH:$PWD/bin;
        mutt && exit;
      '';

    };
}
