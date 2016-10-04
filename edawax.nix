with import <nixpkgs> {}; {
     pyEnv = stdenv.mkDerivation {
       name = "edawax";
       buildInputs = [ 
            stdenv 
            python27Full 
            python27Packages.virtualenv 
            libxml2 
            python27Packages.pip
            libxslt
            zlib
            git
            zsh
            nodejs
            postgresql94
          #  firefox
          #  chromium
          #  chromedriver
      ];
      pathsToLink = [ "/include" "/lib" ];
      shellHook = ''
        export LIBRARY_PATH=/var/run/current-system/sw/lib;
        export C_INCLUDE_PATH=/var/run/current-system/sw/include;
        export LD_LIBRARY_PATH=/var/run/current-system/sw/lib; 
        export PATH=$PATH:$PWD/bin;
      '';

      LIBRARY_PATH="${libxml2}/lib";
      LD_LIBRARY_PATH="$a{postgresql94}/lib";
      #LD_LIBRARY_PATH="/var/run/current-system/sw/lib"; #for postgresql bindings
    };
}
