" rbenv.vim - rbenv support
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0

if exists("g:loaded_rbenv") || v:version < 700 || &cp || !executable('rbenv')
  finish
endif
let g:loaded_rbenv = 1

function! s:rbenv_root()
  return empty($RBENV_ROOT) ? expand('~/.rbenv') : $RBENV_ROOT
endfunction

function! s:ruby_version_paths() abort
  let dict = {}
  let root = s:rbenv_root() . '/versions/'
  for entry in split(glob(root.'*'))
    let ver = entry[strlen(root) : -1]
    let paths = ver =~# '^1.[0-8]' ? ['.'] : []
    let paths += split($RUBYLIB, ':')
    let site_ruby_arch = glob(entry . '/lib/ruby/site_ruby/*.*/*-*')
    if empty(site_ruby_arch) || site_ruby_arch =~# "\n"
      continue
    endif
    let arch = fnamemodify(site_ruby_arch, ':t')
    let minor = fnamemodify(site_ruby_arch, ':h:t')
    let paths += [
          \ entry . '/lib/ruby/site_ruby/' . minor,
          \ entry . '/lib/ruby/site_ruby/' . minor . '/' . arch,
          \ entry . '/lib/ruby/site_ruby',
          \ entry . '/lib/ruby/vendor_ruby/' . minor,
          \ entry . '/lib/ruby/vendor_ruby/' . minor . '/' . arch,
          \ entry . '/lib/ruby/vendor_ruby',
          \ entry . '/lib/ruby/' . minor,
          \ entry . '/lib/ruby/' . minor . '/' . arch]
    let dict[ver] = paths
  endfor
  return dict
endfunction

if !exists('g:ruby_version_paths')
  let g:ruby_version_paths = {}
endif

call extend(g:ruby_version_paths, s:ruby_version_paths(), 'keep')

if exists('$RBENV_VERSION')
  let s:version = $RBENV_VERSION
elseif filereadable(s:rbenv_root() . '/version')
  let s:version = get(readfile(s:rbenv_root() . '/version', '', 1), 0, '')
endif

if exists('s:version') && has_key(g:ruby_version_paths, s:version)
  let g:ruby_default_path = g:ruby_version_paths[s:version]
endif

" vim:set et sw=2:
