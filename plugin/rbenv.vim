" rbenv.vim - rbenv support
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.1

if exists("g:loaded_rbenv") || v:version < 700 || &cp || !executable('rbenv')
  finish
endif
let g:loaded_rbenv = 1

command! -bar -nargs=* -complete=custom,s:Complete Rbenv
      \ if get([<f-args>], 0, '') ==# 'shell' |
      \   exe s:shell(<f-args>) |
      \ else |
      \   exe '!rbenv ' . <q-args> |
      \   call extend(g:ruby_version_paths, s:ruby_version_paths(), 'keep') |
      \ endif

function! s:shell(_, ...)
  if !a:0
    if empty($RBENV_VERSION)
      echo 'rbenv.vim: no shell-specific version configured'
    else
      echo $RBENV_VERSION
    endif
    return ''
  elseif a:1 ==# '--unset'
    let $RBENV_VERSION = ''
  elseif !isdirectory(s:rbenv_root() . '/versions/' . a:1)
    echo 'rbenv.vim: version `' . a:1 . "' not installed"
  else
    let $RBENV_VERSION = a:1
  endif
  call s:set_paths()
  if &filetype ==# 'ruby'
    set filetype=ruby
  endif
  return ''
endfunction

function! s:Complete(A, L, P)
  if a:L =~# ' .* '
    return system("rbenv completions".matchstr(a:L, ' .* '))
  else
    return system("rbenv commands")
  endif
endfunction

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

function! s:set_paths() abort
  call extend(g:ruby_version_paths, s:ruby_version_paths(), 'keep')
  if !empty($RBENV_VERSION)
    let ver = $RBENV_VERSION
  elseif filereadable(s:rbenv_root() . '/version')
    let ver = get(readfile(s:rbenv_root() . '/version', '', 1), 0, '')
  else
    return
  endif
  if has_key(g:ruby_version_paths, ver)
    let g:ruby_default_path = g:ruby_version_paths[ver]
  else
    unlet! g:ruby_default_path
  endif
endfunction

call s:set_paths()

function! s:projectile_detect() abort
  let root = s:rbenv_root() . '/plugins/'
  if g:projectile_file[0 : len(root)-1] ==# root
    call projectile#append(root . matchstr(g:projectile_file, '[^/]\+', len(root)), {
          \ "bin/rbenv-*": {"command": "command", "template": [
          \   '#!/usr/bin/env bash',
          \   '#',
          \   '# Summary:',
          \   '#',
          \   '# Usage: rbenv {}',
          \ ]},
          \ "etc/rbenv.d/*.bash": {"command": "hook"}})
  endif
endfunction

augroup rbenv
  autocmd!
  autocmd User ProjectileDetect call s:projectile_detect()
augroup END

" vim:set et sw=2:
