"pathogen
execute pathogen#infect()
"let g:tagbar_ctags_bin="/home/teja/apps/universal_ctags/usr_local/bin/ctags"

syntax on
filetype plugin indent on

colorscheme desert
"set tabstop=8
"set cin		"C indenting
set smartindent	"intelligent indentation
set nu		"line no.s
set rnu     "relative line no.s
set foldmethod=manual
"set guioptions-=T
"setlocal shiftwidth=4
"set statusline+=%F
"show tab as |<space><space><space>
":set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set listchars=tab:\|\ ,trail:~
set list
":set mouse=a

"set cursorline ctermbg=white cterm=bold

set scrolloff=3

"hightlight search results
set incsearch
set hlsearch

" enable gdb
packadd termdebug
let g:termdebug_wide=1


set colorcolumn=80
autocmd BufEnter  COMMIT_EDITMSG set spell
autocmd BufEnter  COMMIT_EDITMSG set colorcolumn=70
autocmd BufLeave  COMMIT_EDITMSG set colorcolumn=80
highlight ColorColumn guibg=black

"set shell options
set shell=/bin/bash
set shellcmdflag=-ic

" testing. temp.: D del always into blackhole. d is cut
nnoremap DD "_dd
nnoremap Dw "_dw
vnoremap D  "_d


"cscope re-init
"cs reset

"status line settings
set laststatus=2
set statusline=%F "full filename
set statusline +=\ [%{tagbar#currenttag('%s','')}] "function name
"commented for now
set statusline+=\ %{fugitive#statusline()} "git branchname
set statusline+=\ %P:%c "percentage
set statusline+=\ %m "modified
"set statusline+=%F

"highlight current line
:hi CursorLine   cterm=NONE ctermbg=Green ctermfg=white
":hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
":hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>l :set cursorline! cursorcolumn!<CR>




"Vim plug
call plug#begin('~/.vim/plugged')
"Plug 'junegunn/goyo.vim'
"Plug 'junegunn/limelight.vim'
"Plug 'rr-/vim-hexdec'
Plug 'junegunn/vim-peekaboo'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'kjssad/quantum.vim'
"Plug 'dense-analysis/ale'
"Plug 'alx741/vim-hindent'
Plug 'rightson/vim-p4-syntax'

call plug#end()

let b:showSpaces = 1

let g:ale_fixers = {
\   'C': ['gcc', 'clang-check-9'],
\}


"gitgutter
"let g:gitgutter_signs = 0

"intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

"******    teja's mappings   ******
"removed since enabling mappings specific to buffer type
"goto normal mode
"nnoremap qw <ESC>
"inoremap qw <ESC> "removing those which interfere in insert mode
"\w is write in both insert and normal mode
"inoremap \w <ESC>:w<CR>i  "removing those which interfere in insert mode
"nnoremap \w <ESC>:w<CR>
"\q is write and quit in both insert and normal mode
"inoremap \q <ESC>:wq<CR>  "removing those which interfere in insert mode
"nnoremap \q <ESC>:wq<CR>

"show search results cute
"nnoremap \s :execute 'g//z#.5 \| echo "==============="' <CR>

"TagbarToggle
nnoremap <F8> :TagbarToggle<CR>
inoremap <F8> <ESC>:TagbarToggle<CR>a
"nnoremap \t :TagbarToggle<CR>

"commenting lines

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
autocmd BufEnter *.cpp set ts=4 sts=4 sw=4 expandtab
autocmd BufEnter *.cpp IndentGuidesEnable

"for python
autocmd BufEnter  *.py  inoremap \c <ESC>^i#
autocmd BufEnter  *.py  nnoremap \c ^i#<ESC>
autocmd BufEnter  *.py  vnoremap \c ^<C-v>I#<ESC>
   "remove comment
autocmd BufEnter  *.py  inoremap \xc <ESC>^xi
autocmd BufEnter  *.py  vnoremap \xc :s/#//<CR>
autocmd BufEnter  *.py  nnoremap \xc ^x<ESC>
autocmd BufEnter  *.py  set autoindent noexpandtab tabstop=4 shiftwidth=4
autocmd BufEnter *.py IndentGuidesEnable

"for java
autocmd BufEnter  *.java  inoremap \c <ESC>^i//
autocmd BufEnter  *.java  nnoremap \c ^i//<ESC>
autocmd BufEnter  *.java  vnoremap \c ^<C-v>I//<ESC>
   "remove comment
autocmd BufEnter  *.java  inoremap \xc <ESC>^xxi
autocmd BufEnter  *.java  vnoremap \xc :s/\/\///<CR>
autocmd BufEnter  *.java  nnoremap \xc ^xx<ESC>
autocmd BufEnter  *.java  set autoindent expandtab tabstop=4 shiftwidth=4


" for asn files
autocmd BufEnter *.asn set tabstop=4
autocmd BufEnter *.asn inoremap \c <ESC>^i--
autocmd BufEnter *.asn nnoremap \c ^i--<ESC>
autocmd BufEnter *.asn vnoremap \c ^<C-v>I--<ESC>
   "remove comment
autocmd BufEnter *.asn inoremap \xc <ESC>^xxi
autocmd BufEnter *.asn vnoremap \xc :s/--//<CR><ESC>noh<CR>
autocmd BufEnter *.asn nnoremap \xc ^xx<ESC>

" for yaml files:  add yaml stuffs
"au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
"autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
"autocmd BufEnter *.yaml IndentGuidesEnable

" for tex files
autocmd BufEnter *.tex set spell
autocmd BufEnter *.tex inoremap <C-c> <ESC>^i%
autocmd BufEnter *.tex nnoremap <C-c> ^i%<ESC>
autocmd BufEnter *.tex vnoremap <C-c> ^<C-v>I%<ESC>
   "remove comment
autocmd BufEnter *.tex inoremap <C-C> <ESC>^xi
autocmd BufEnter *.tex vnoremap <C-C> :s/%//<CR><ESC>noh<CR>
autocmd BufEnter *.tex nnoremap <C-C> ^x<ESC>

"for lua
"autocmd BufEnter  *.lua  inoremap \c <ESC>^i--
autocmd BufEnter  *.lua  nnoremap \c ^i--<ESC>
autocmd BufEnter  *.lua  vnoremap \c ^<C-v>I--<ESC>
   "remove comment
"autocmd BufEnter  *.lua  inoremap \xc <ESC>^xi
autocmd BufEnter  *.lua  vnoremap \xc :s/--//<CR>:noh<CR>
autocmd BufEnter  *.lua  nnoremap \xc ^xx<ESC>

autocmd BufEnter *.tex set ts=4 sts=4 sw=4 expandtab

"autocmd BufEnter *.yaml hi IndentGuidesOdd ctermbg=none
"         --> changed it in plugin itself


	"for networkx
"autocmd BufEnter  *.py execute 'setlocal dict+=~/.vim/words/networkx.txt'
	"autocomplete
"autocmd BufEnter  *.py  inoremap \n <C-n>
"autocmd BufEnter  *.py  inoremap \m <C-x><C-k>

"for haskell
"let g:hindent_on_save = 0
"let g:hindent_indent_size = 4

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



"for rust
autocmd BufEnter *.rs inoremap \c <ESC>^i//
autocmd BufEnter *.rs nnoremap \c ^i//<ESC>
"autocmd BufEnter *.rs "inoremap \sc <ESC>^i/*     <--- improve
"autocmd BufEnter *.rs "inoremap \ <ESC>$a*/
autocmd BufEnter *.rs vnoremap \c ^<C-v>I//<ESC>
   "remove comment
autocmd BufEnter *.rs inoremap \xc <ESC>^xxi
autocmd BufEnter *.rs vnoremap \xc :s/\/\///<CR>
autocmd BufEnter *.rs nnoremap \xc ^xx<ESC>
autocmd BufEnter *.rs set ts=4 sts=4 sw=4 expandtab
autocmd BufEnter *.rs IndentGuidesEnable

"copy and paste
"vnoremap \y "+y
"inoremap \P <ESC>"+gP<CR>i
"nnoremap \p "+gP<CR>i
"inoremap \p <Esc>pi

"goto other side
"inoremap \<tab> <Esc><C-w><C-w>i
nnoremap \<tab> <C-w><C-w>

"marks plugin
nnoremap \N :MarkClear<cr>

"for C
autocmd BufEnter *.cc inoremap \c <ESC>^i//
autocmd BufEnter *.cc nnoremap \c ^i//<ESC>
"autocmd BufEnter *.cc "inoremap \sc <ESC>^i/*     <--- improve
"autocmd BufEnter *.cc "inoremap \ <ESC>$a*/
autocmd BufEnter *.cc vnoremap \c ^<C-v>I//<ESC>
   "remove comment
autocmd BufEnter *.cc inoremap \xc <ESC>^xxi
autocmd BufEnter *.cc vnoremap \xc :s/\/\///<CR>
autocmd BufEnter *.cc nnoremap \xc ^xx<ESC>
autocmd BufEnter *.cc set ts=8 sts=8 sw=8
"autocmd BufEnter *.c IndentGuidesEnable

"for C header files :)
autocmd BufEnter *.hpp inoremap \c <ESC>^i//
autocmd BufEnter *.hpp nnoremap \c ^i//<ESC>
"autocmd BufEnter *.hpp "inoremap \sc <ESC>^i/*     <--- improve
"autocmd BufEnter *.hpp "inoremap \ <ESC>$a*/
autocmd BufEnter *.hpp vnoremap \c ^<C-v>I//<ESC>
   "remove comment
autocmd BufEnter *.hpp inoremap \xc <ESC>^xxi
autocmd BufEnter *.hpp vnoremap \xc :s/\/\///<CR>
autocmd BufEnter *.hpp nnoremap \xc ^xx<ESC>
autocmd BufEnter *.hpp set ts=8 sts=8 sw=8
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

"for java
"autocmd BufEnter *.java inoremap \c <ESC>^i//
autocmd BufEnter *.java nnoremap \c ^i//<ESC>
"autocmd BufEnter *.java "inoremap \sc <ESC>^i/*     <--- improve
"autocmd BufEnter *.java "inoremap \ <ESC>$a*/
autocmd BufEnter *.java vnoremap \c ^<C-v>I//<ESC>
   "remove comment
autocmd BufEnter *.java inoremap \xc <ESC>^xxi
autocmd BufEnter *.java vnoremap \xc :s/\/\///<CR>
autocmd BufEnter *.java nnoremap \xc ^xx<ESC>
autocmd BufEnter *.java set ts=4 sts=4 sw=4 expandtab
autocmd BufEnter *.java IndentGuidesEnable
"folding options
"vnoremap zz zf
"inoremap zz <Esc>zai
"nnoremap zz za
"inoremap \zB <Esc>vaBzf

autocmd BufEnter *.html set ts=2 sts=2 sw=2 expandtab
autocmd BufEnter *.html IndentGuidesEnable

"nnoremap \2 :execute(':call StartTagbar2()')<cr>mqVggG`q<Esc>

"function! StartTagbar2()
"	execute('! echo '.expand('%:p').' > ~/.vim/plugin/tagbar2/curr_info')
"	echom "MEOW"
"endfunction

"find using ripgrep
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options


"function! PecoOpen()
"  for filename in split(system("find . -type f | ~/grep_tools/peco_linux_amd64/peco"), "\n")
"    "echo filename
"    execute "e" filename
"  endfor
"endfunction
"nnoremap \op :call PecoOpen()<CR>

" centered read mode
"nnoremap \J :source ~/.vim/center_read_ON_.vim<cr>
"nnoremap \K :source ~/.vim/center_read_OFF_.vim<cr>

"nnoremap \R :source ~/.vim/plugin/cscope_maps.vim

"highlight current line


"cscope movethru results
"set cscopequickfix=s-,c-,d-,i-,t-,e-
