#user profile configuration file for nix

# see https://nixos.org/wiki/Howto_keep_multiple_packages_up_to_date_at_once
# and http://aflatter.de/managing-home-with-nix/
{
  packageOverrides = pkgs: with pkgs; {

    vimEnv = with pkgs; buildEnv {
      name = "vimEnv";
      #XXX jedi and geeknote do not work yet, since pathes are not known
      # vim-jedi and vim-flake8 are still in bundle, no vimPlugin yet
      # TODO: write nix config for vim-jedi and vim-flake8
      paths = [
        vim_configurable

        #solarized is in .vim/colors, does not work via Nix installation
        #vimPlugins.Solarized
        vimPlugins.ctrlp
        vimPlugins.nerdtree
        vimPlugins.tagbar
        vimPlugins.taglist
        vimPlugins.Syntastic
        vimPlugins.pluginnames2nix
        vimPlugins.vim-jinja
        vimPlugins.vim-nerdtree-tabs
        vimPlugins.vim-buffergator
        python27Packages.geeknote
        python27Packages.jedi
        #python27Packages.python
        vimPlugins.fugitive
        ];
    };

#    atomEnv = with pkgs; buildEnv {
#        name = "atomEnv";
#        paths = [
#            atom
#            python27Packages.autopep8
#            ctags
#        ];
#
#    };

  };


allowUnfree = true;
}
