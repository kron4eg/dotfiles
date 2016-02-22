" vim: set fdm=marker:

if &compatible
  set nocompatible
end

" PLUG INIT {{{1
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&
    \ mkdir -p ~/.config && ln -s ~/.vim ~/.config/nvim && ln -s ~/.vimrc ~/.config/nvim/init.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" END PLUG INIT 1}}}

" PLUGINS {{{1
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

" Colorscheme
Plug 'tomasr/molokai'

Plug 'tpope/vim-commentary'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Find files/buffers
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'

" Status line
Plug 'itchyny/lightline.vim'

Plug 'bronson/vim-trailing-whitespace'

" Ctags
Plug 'majutsushi/tagbar'

" Go
Plug 'fatih/vim-go'

" Ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tpope/vim-endwise'
Plug 'sunaku/vim-ruby-minitest'

"Javascript
Plug 'mustache/vim-mustache-handlebars'
Plug 'leafgarland/typescript-vim'
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'

" Rust
Plug 'rust-lang/rust.vim'

" Toml
Plug 'cespare/vim-toml'

" Different
Plug 'chrisbra/SudoEdit.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-dotenv'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'moll/vim-bbye'
Plug 'vim-utils/vim-man'
Plug 'junkblocker/patchreview-vim'

Plug 'scrooloose/syntastic'

Plug 'Raimondi/delimitMate'

" Databases
Plug 'vim-scripts/dbext.vim'
call plug#end()
" END PLUGINS 1}}}

" GENERAL VIM SETTINGS {{{1
filetype plugin indent on
set completeopt=menu
set autoread
set splitright
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set visualbell t_vb=
set keywordprg=":help"
"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif
"" Encoding
if !has('nvim')
    set encoding=utf-8
endif
set fileencoding=utf-8
set fileencodings=utf-8
"" Fix backspace indent
set backspace=indent,eol,start
"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
"" Enable hidden buffers
set hidden
"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
"" Encoding
set nobomb
set ttyfast
"" Directories for swp files
set nobackup
set noswapfile
set autowrite
set updatecount=10
set fileformats=unix,dos,mac
set showcmd
"" Visual Settings
syntax on
set ruler
set relativenumber
set number
set numberwidth=5
set listchars=tab:▸\ ,eol:¬
set nolist
set laststatus=2
set noshowmode
set title
set titleold="Terminal"
set titlestring=%F
" END GENERAL VIM SETTINGS 1}}}

" PLUGIN SETTINGS {{{1
let g:go_fmt_command = "goimports"

" netrw settings
let s:escape = 'substitute(escape(v:val, ".$~"), "*", ".*", "g")'
let s:dotfiles = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_banner = 0
let g:netrw_sort_sequence = '[\/]$,*,\%(' . join(map(split(&suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$'
let g:netrw_list_hide =
      \ join(map(split(&wildignore, ','), '"^".' . s:escape . '. "$"'), ',') . ',^\.\.\=/\=$' .
      \ (get(g:, 'netrw_list_hide', '')[-strlen(s:dotfiles)-1:-1] ==# s:dotfiles ? ','.s:dotfiles : '')

let g:rehash256 = 1
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete

" statusline config
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:rustfmt_autosave = 1

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

let g:tagbar_autofocus = 1

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
        \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
        \ 'r:constructor', 'f:functions' ],
    \ 'sro' : '.',
    \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
    \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

" END PLUGIN SETTINGS 1}}}

" COLORSCHEME {{{1
colorscheme molokai
set t_Co=256
" END COLORSCHEME 1}}}

" AUTOCOMMANDS {{{1
"" Remember cursor position
augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" make/cmake
augroup vimrc-make-cmake
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" vim-python
augroup vimrc-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
        \ formatoptions+=croq softtabstop=4 smartindent
        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

augroup FileType go
    autocmd!
    autocmd FileType go nmap gd <Plug>(go-def)
    autocmd FileType go nmap <Leader>dd <Plug>(go-def-vertical)
    autocmd FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
    autocmd FileType go nmap <Leader>gi <Plug>(go-info)
    autocmd FileType go nmap <leader>gr <Plug>(go-run)
    autocmd FileType go nmap <leader>rb <Plug>(go-build)
    autocmd FileType go nmap <leader>ii <Plug>(go-install)
    autocmd FileType go nmap <leader>gt <Plug>(go-test)
augroup END


augroup vimrc-ruby
    autocmd!
    autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
    autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab
augroup END

" 1}}}

" CUSTOM COMMANDS {{{1
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
" END CUSTOM COMMANDS 1}}}

" VIM MAPPINGS {{{1
let mapleader=' '
nnoremap <leader>ev :e $MYVIMRC<CR>

" toggle gundo
nnoremap <F5> :GundoToggle<CR>

" tab navigations
nmap <tab> gt
nmap <s-tab> gT

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Buffer nav
nnoremap <silent> <UP>    :cprev<CR>
nnoremap <silent> <DOWN>  :cnext<CR>
nnoremap <silent> <LEFT>  :bp<CR>
nnoremap <silent> <RIGHT> :bn<CR>
nnoremap <leader>b :ls<CR>:b<space>
nnoremap <leader>c :Bdelete<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

if has('nvim')
    :tnoremap <A-h> <C-\><C-n><C-w>h
    :tnoremap <A-j> <C-\><C-n><C-w>j
    :tnoremap <A-k> <C-\><C-n><C-w>k
    :tnoremap <A-l> <C-\><C-n><C-w>l
endif
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" save file
imap <F2> <Esc>:w<CR>a
nmap <F2> :w<CR>

" save all files
imap <S-F2> <Esc>:wa<CR>a
nmap <S-F2> :wa<CR>

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
" END VIM MAPPINGS 1}}}
