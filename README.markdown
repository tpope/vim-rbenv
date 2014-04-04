# rbenv.vim

This simple plugin provides a `:Rbenv` command that wraps `!rbenv` with tab
complete.  It also tells recent versions of [vim-ruby][] where your Ruby
installs are located, so that it can set `'path'` and [`'tags'`][rbenv-ctags]
in your Ruby buffers to reflect the nearest `.ruby-version` file.

Bonus: [projectile.vim][] support for rbenv plugins.

[vim-ruby]: https://github.com/vim-ruby/vim-ruby
[rbenv-ctags]: https://github.com/tpope/rbenv-ctags
[projectile.vim]: https://github.com/tpope/vim-projectile

## Installation

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/tpope/vim-rbenv.git

## FAQ

> My Vim insists on using the system Ruby.

You're using zsh on OS X, aren't you? Here are some things to try:

* Move `/etc/zshenv` to `/etc/zshrc`.
* Set your `PATH` in `~/.zshenv` instead of `~/.zshrc`.

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
