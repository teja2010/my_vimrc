set nu
set rnu
syntax on
filetype plugin indent on

set nocompatible
set showmode
set smartcase
set smarttab
set smartindent
set autoindent
"set expandtab
set colorcolumn=80
set background=dark

set listchars=tab:\|\ ,trail:~
set list

set scrolloff=3
set incsearch
set hlsearch

" most of the config is from
" https://mendo.zone/fun/neovim-setup-haskell/
" https://www.stephendiehl.com/posts/vim_2016.html

call plug#begin(stdpath('config') . '/plugged')

Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'neovimhaskell/haskell-vim'
Plug 'neomake/neomake'
Plug 'alx741/vim-hindent'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'bitc/vim-hdevtools'
"Plug 'liuchengxu/vista.vim'
"Plug 'inkarkat/vim-mark'

call plug#end()

nnoremap <F8> :TagbarToggle<CR>

" comments for haskell
autocmd BufEnter *.hs inoremap \c <ESC>^i--
autocmd BufEnter *.hs nnoremap \c ^i-- <ESC>
"autocmd BufEnter *.hs "inoremap \sc <ESC>^i/*     <--- improve
"autocmd BufEnter *.hs "inoremap \ <ESC>$a*/
autocmd BufEnter *.hs vnoremap \c ^<C-v>I-- <ESC>
   "remove comment
autocmd BufEnter *.hs inoremap \xc <ESC>^xxxi
autocmd BufEnter *.hs vnoremap \xc :s/-- //<CR>:noh<CR>
autocmd BufEnter *.hs nnoremap \xc ^xxx<ESC>:noh<CR>
autocmd BufEnter *.hs set ts=4 sts=4 sw=4 expandtab
autocmd BufEnter *.hs IndentGuidesEnable

autocmd BufEnter *.cabal set ts=4 sts=4 sw=4 expandtab

"haskell-vim options
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 4
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 2
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 4
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 4
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

" neomake
call neomake#configure#automake('nrwi', 500)
"let g:neomake_open_list = 2

"hdevtools
let g:hdevtools_stack = 1
"au FileType haskell nnoremap <buffer> K :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <C-I> :HdevtoolsInfo<CR>
"au FileType haskell nnoremap <buffer> <silent> <C-K> :HdevtoolsClear<CR>


" dont run hindent on write
autocmd BufEnter *.hs let g:hindent_on_save = 0

" start deoplete on startup
autocmd BufEnter *.hs let g:deoplete#enable_at_startup = 1

" language server support for ghcide
set hidden
let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ 'haskell': ['ghcide', '--lsp'],
    \ }

"autocmd BufEnter *hs nnoremap <C-\> :call LanguageClient_contextMenu()<CR>
autocmd BufEnter *hs nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"autocmd BufEnter *hs nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" tagbar haskell
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'i:instance:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type',
        \ 'i' : 'instance'
    \ },
    \ 'scope2kind' : {
        \ 'module'   : 'm',
        \ 'class'    : 'c',
        \ 'data'     : 'd',
        \ 'type'     : 't',
        \ 'instance' : 'i'
    \ }
\ }

autocmd BufReadPost *
   \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
   \ |   exe "normal! g`\""
   \ | endif

