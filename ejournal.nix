with import <nixpkgs> {}; {
     pyEnv = stdenv.mkDerivation {
       name = "ejournal";
       buildInputs = [ 
            stdenv 
            python27Full 
            python27Packages.virtualenv 
            libxml2 
            python27Packages.pip
            python27Packages.pillow
            python27Packages.ipdb
            libxslt
            zlib
            libzip
            git
            zsh
            fop
            xpdf
            libjpeg
            libpng
            freetype
      ];
      #pathsToLink = [ "/include" "/lib" ];
      shellHook = ''
      #   
      #export LIBRARY_PATH=/var/run/current-system/sw/lib;
      #export C_INCLUDE_PATH=/var/run/current-system/sw/include;
      '';

      LIBRARY_PATH="${libxml2}/lib;${libxslt}/lib";
    };
}
