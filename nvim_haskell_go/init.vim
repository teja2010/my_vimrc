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
Plug 'deoplete-plugins/deoplete-jedi'
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
"Plug 'junegunn/fzf'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'bitc/vim-hdevtools'
"Plug 'liuchengxu/vista.vim'
"Plug 'inkarkat/vim-mark'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovim/nvim-lspconfig'

call plug#end()

nnoremap <F8> :TagbarToggle<CR>

" lspconfig config
lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "gopls", "rust_analyzer", "hls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF


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
autocmd BufEnter *hs call neomake#configure#automake('nrwi', 500)
"g:neomaker_haskell_enabled_makers = ['hlint']
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

" language server support for ghcide " lspconfig now
"set hidden
"let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']
"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['rls'],
"    \ 'haskell': ['haskell-language-server-wrapper', '--lsp']
"    \ }
"
""\ 'haskell': ['ghcide', '--lsp'],
"
""autocmd BufEnter *hs nnoremap <C-\> :call LanguageClient_contextMenu()<CR>
"autocmd BufEnter *hs nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
""autocmd BufEnter *hs nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
""nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

"autocmd BufEnter *rs nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

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

source ~/.config/nvim/mark.vim
source ~/.config/nvim/cscope_maps.vim

let b:ale_linters = { 'python': ['pylint'], 'c': ['gcc', 'clang-tidy-9'], 'cpp' : ['g++'] , 'go' : ['golint', 'go vet', 'gotype']}
let g:ale_linters_explicit = 1
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '[=) All Good]' : printf(
    \   '[W:%d E:%d]',
    \   all_non_errors,
    \   all_errors
    \)
endfunction


""" vim-go settings
let g:go_imports_autosave = 0

set laststatus=2
set statusline=%F "full filename
set statusline +=\ [%{tagbar#currenttag('%s','')}] "function name
"commented for now
set statusline+=%{LinterStatus()}
set statusline+=\ %{fugitive#statusline()} "git branchname
set statusline+=\ %P:%c "percentage
set statusline+=\ %m "modified
"set statusline+=%F

"for python
autocmd BufEnter  *.py  inoremap \c <ESC>^i#
autocmd BufEnter  *.py  nnoremap \c ^i#<ESC>
autocmd BufEnter  *.py  vnoremap \c ^<C-v>I#<ESC>
   "remove comment
autocmd BufEnter  *.py  inoremap \xc <ESC>^xi
autocmd BufEnter  *.py  vnoremap \xc :s/#//<CR>
autocmd BufEnter  *.py  nnoremap \xc ^x<ESC>
autocmd BufEnter  *.py  set autoindent expandtab tabstop=4 shiftwidth=4
"autocmd BufEnter *.py IndentGuidesEnable

"for CPP
autocmd BufEnter *.cpp inoremap \c <ESC>^i//
autocmd BufEnter *.cpp nnoremap \c ^i//<ESC>
"autocmd BufEnter *.cpp "inoremap \sc <ESC>^i/*     <--- improve
"autocmd BufEnter *.cpp "inoremap \ <ESC>$a*/
autocmd BufEnter *.cpp vnoremap \c ^<C-v>I//<ESC>
   "remove comment
autocmd BufEnter *.cpp inoremap \xc <ESC>^xxi
autocmd BufEnter *.cpp vnoremap \xc :s/\/\///<CR>
autocmd BufEnter *.cpp nnoremap \xc ^xx<ESC>
autocmd BufEnter *.cpp set ts=8 sts=8 sw=8
"autocmd BufEnter *.cpp IndentGuidesEnable

"for C
autocmd BufEnter *.c inoremap \c <ESC>^i//
autocmd BufEnter *.c nnoremap \c ^i//<ESC>
"autocmd BufEnter *.c "inoremap \sc <ESC>^i/*     <--- improve
"autocmd BufEnter *.c "inoremap \ <ESC>$a*/
autocmd BufEnter *.c vnoremap \c ^<C-v>I//<ESC>
   "remove comment
autocmd BufEnter *.c inoremap \xc <ESC>^xxi
autocmd BufEnter *.c vnoremap \xc :s/\/\///<CR>
autocmd BufEnter *.c nnoremap \xc ^xx<ESC>
autocmd BufEnter *.c set ts=8 sts=8 sw=8
"autocmd BufEnter *.c IndentGuidesEnable

"for C header files :)
autocmd BufEnter *.h inoremap \c <ESC>^i//
autocmd BufEnter *.h nnoremap \c ^i//<ESC>
"autocmd BufEnter *.h "inoremap \sc <ESC>^i/*     <--- improve
"autocmd BufEnter *.h "inoremap \ <ESC>$a*/
autocmd BufEnter *.h vnoremap \c ^<C-v>I//<ESC>
   "remove comment
autocmd BufEnter *.h inoremap \xc <ESC>^xxi
autocmd BufEnter *.h vnoremap \xc :s/\/\///<CR>
autocmd BufEnter *.h nnoremap \xc ^xx<ESC>
autocmd BufEnter *.h set ts=8 sts=8 sw=8
"autocmd BufEnter *.h set ts=4 sts=4 sw=4 expandtab
"autocmd BufEnter *.h IndentGuidesEnable

"for golang
autocmd BufEnter *.go inoremap \c <ESC>^i//
autocmd BufEnter *.go nnoremap \c ^i//<ESC>
"autocmd BufEnter *.go "inoremap \sc <ESC>^i/*     <--- improve
"autocmd BufEnter *.go "inoremap \ <ESC>$a*/
autocmd BufEnter *.go vnoremap \c ^<C-v>I//<ESC>
   "remove comment
autocmd BufEnter *.go inoremap \xc <ESC>^xxi
autocmd BufEnter *.go vnoremap \xc :s/\/\///<CR>
autocmd BufEnter *.go nnoremap \xc ^xx<ESC>
autocmd BufEnter *.go set ts=8 sts=8 sw=8
