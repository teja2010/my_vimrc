
syntax on
filetype plugin indent on
set smartindent
set nu
set rnu
set listchars=tab:\|\ ,trail:~
set list

set incsearch
set hlsearch

set colorcolumn=100
set scrolloff=3

"status line settings
set laststatus=2
set statusline=%F "full filename
set statusline+=\ %{LinterStatus()}
set statusline +=\ [%{tagbar#currenttag('%s','')}] "function name
set statusline+=\ %{fugitive#statusline()} "git branchname
set statusline+=\ %P "percentage
set statusline+=\ %m "modified

"Vim plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim'
Plug 'dense-analysis/ale'
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'deoplete-plugins/deoplete-jedi'
call plug#end()

let g:ale_linters = {
	\ 'python': ['pylint']
	\}

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '[ all good =)]' : printf(
    \   '[%d W, %d E]',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

let g:deoplete#enable_at_startup = 1

"for python
autocmd BufEnter  *.py  inoremap \c <ESC>^i#
autocmd BufEnter  *.py  nnoremap \c ^i#<ESC>
autocmd BufEnter  *.py  vnoremap \c ^<C-v>I#<ESC>
   "remove comment
autocmd BufEnter  *.py  inoremap \xc <ESC>^xi
autocmd BufEnter  *.py  vnoremap \xc :s/#//<CR>
autocmd BufEnter  *.py  nnoremap \xc ^x<ESC>
autocmd BufEnter  *.py  set autoindent noexpandtab tabstop=4 shiftwidth=4
"autocmd BufEnter *.py IndentGuidesEnable
"autocmd BufEnter *.py TagbarOpen


