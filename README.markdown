# rbenv.vim

This plugin tells recent versions of [vim-ruby][] where your Ruby installs are
located, so that it can set `'path'` and [`'tags'`][rbenv-ctags] in your Ruby
buffers to reflect the `$LOAD_PATH` of the Ruby version specified in the
nearest `.ruby-version` file.

Without this plugin, vim-ruby figures out the `$LOAD_PATH` by shelling out and
asking Ruby itself.  Thus, the only thing this plugin has to offer is a small
performance boost.

[vim-ruby]: https://github.com/vim-ruby/vim-ruby
[rbenv-ctags]: https://github.com/tpope/rbenv-ctags

## Installation

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/tpope/vim-rbenv.git

## FAQ

> My Vim insists on using the system Ruby.

You're using zsh on OS X, aren't you?  Move that stupid `/etc/zshenv`
to `/etc/zshrc`.

## Self-Promotion

Like rbenv.vim? Follow the repository on
[GitHub](https://github.com/tpope/vim-rbenv) and vote for it on
[vim.org](http://www.vim.org/scripts/script.php?script_id=4455).  And if
you're feeling especially charitable, follow [tpope](http://tpo.pe/) on
[Twitter](http://twitter.com/tpope) and
[GitHub](https://github.com/tpope).

## License

Copyright (c) Tim Pope.  Distributed under the same terms as Vim itself.
See `:help license`.
