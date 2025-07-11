" General {{{
set nocompatible

syntax on
filetype plugin indent on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set encoding=utf8
set number relativenumber
set backspace=indent,eol,start
set timeoutlen=1000
set ttimeoutlen=1

set hidden

set incsearch
set ignorecase
set smartcase

set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//
set viminfofile=$XDG_STATE_HOME/viminfo
" }}}
" Keymaps {{{
let mapleader = " "

nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
" }}}
" Appearance {{{
set ruler
set wildmenu
set lazyredraw
set display=lastline
set laststatus=2
set scrolloff=2
set showcmd
set fillchars+=vert:\ 

set noerrorbells
set novisualbell
set t_vb=

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set t_Co=16
set colorcolumn=78

hi ColorColumn                  ctermbg=DarkGrey
hi Cursorline                   ctermbg=DarkGrey cterm=NONE
hi ErrorMsg      ctermfg=Red    ctermbg=NONE
hi Error         ctermfg=Red    ctermbg=NONE
hi MatchParen    ctermfg=Yellow ctermbg=NONE     cterm=bold
hi Pmenu         ctermfg=White  ctermbg=Black
hi PmenuMatch    ctermfg=Yellow
hi PmenuMatchSel ctermfg=Yellow ctermbg=DarkGrey
hi PmenuSel      ctermfg=White  ctermbg=DarkGrey
hi StatusLine    ctermfg=Black  ctermbg=White
hi StatusLineNC  ctermfg=Black  ctermbg=White
hi VertSplit     ctermfg=Black
hi lineNr        ctermfg=8
hi Search                       ctermbg=DarkGrey
hi qfFileName    ctermfg=Blue                    cterm=bold
hi qfLineNr      ctermfg=Grey                    cterm=bold
hi Folded                       ctermbg=DarkGrey

hi Character    ctermfg=Green
hi Comment      ctermfg=DarkGrey ctermbg=NONE    cterm=italic
hi Constant     ctermfg=Yellow
hi Identifier   ctermfg=Blue
hi Include      ctermfg=Cyan
hi Keyword      ctermfg=Cyan
hi String       ctermfg=Green
hi Type         ctermfg=Blue
" }}}
" Plugins {{{
packadd! matchit

runtime ftplugin/man.vim
set keywordprg=:Man

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let g:plug_window = 'enew'
" }}}
" Ripgrep {{{
if executable("rg")
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
" }}}
" Lf {{{
if executable("lf")
    nnoremap <leader>e :Lf .<CR>
    nnoremap <leader>E :Lf %:p:h<CR>

    function! Lf(path)
        let temp = tempname()
        let l:cmd = 'lf'
        silent! let l:status = system('command -v lfcd')
        if l:status =~ '\w\+'
            let l:cmd = 'lfcd'
        endif
        exec 'silent !' . l:cmd . ' -selection-path='
            \ . shellescape(temp)
            \ . ' '
            \ . expand(a:path)
        if !filereadable(temp)
            redraw!
            return
        endif
        let names = readfile(temp)
        if empty(names)
            redraw!
            return
        endif
        exec 'edit ' . fnameescape(names[0])
        for name in names[1:]
            exec 'argadd ' . fnameescape(name)
        endfor
        redraw!
    endfunction

    command! -nargs=? -complete=dir Lf call Lf(<q-args>)

    augroup ReplaceNetrwByLf
        au VimEnter * silent! autocmd! FileExplorer
        au BufEnter * let s:buf_path = expand("%")
            \| if isdirectory(s:buf_path)
                \| bdelete!
                \| call timer_start(100, {->Lf(s:buf_path)})
            \| endif
    augroup END
endif
" }}}
" Fzf {{{
if executable("fzf")
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fg :GFiles<CR>
    nnoremap <leader>fb :Buffers<CR>
    nnoremap <leader>fr :Rg!<CR>

    call plug#begin()

    Plug 'junegunn/fzf.vim'

    call plug#end()

    let g:fzf_vim = {}
    let g:fzf_vim.preview_window = []
    let g:fzf_layout = { 'down': '30%' }

    if executable("rg")
        function! RipgrepFzf(query, fullscreen)
          let command_fmt = 'rg '
            \ . '--column '
            \ . '--line-number '
            \ . '--no-heading '
            \ . '--color=always '
            \ . '--smart-case '
            \ . '-- %s || true'
          let initial_command = printf(command_fmt, shellescape(a:query))
          let reload_command = printf(command_fmt, '{q}')
          let spec = {
            \ 'options': [
                \ '--phony',
                \ '--query', a:query,
                \ '--bind',
                \ 'change:reload:' . reload_command,
            \ ]
          \ }
          call fzf#vim#grep(
              \ initial_command,
              \ 1,
              \ fzf#vim#with_preview(spec, 'right'),
              \ a:fullscreen
          \ )
        endfunction

        command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
    endif
endif
" }}}

" vim:ts=4:sts=4:sw=4:et:fdm=marker:fdls=0
