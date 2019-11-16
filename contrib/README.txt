The bash script in this directory is a hook for ruby-build, the rbenv plugin
that provides interpreter installation and removal functions.

The script pre-calculates the value of the g:ruby_version_paths variable used
by vim-ruby and vim-rbenv upon any interpreter installation or removal and
saves that information in the .vim_ruby_version_paths file in your home
directory, thus leading to ***MASSIVE*** speedup times at Vim startup.

It can be installed by simply copying it in the following directories:

  ~/.rbenv/rbenv.d/install
  ~/.rbenv/rbenv.d/uninstall

Then, you need to add the following code at the beginning of your .vimrc:

  " Use precalculated g:ruby_version_paths to speed up load time
  " (need to do this before file type detection support is loaded)
  if filereadable(expand("~/.vim_ruby_version_paths"))
    source $HOME/.vim_ruby_version_paths
  endif

to make it source the ~/.vim_ruby_version_paths file containing the
pre-calculated value of g:ruby_version_paths.
