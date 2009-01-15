set nocompatible

set wildmenu
set wcm=<Tab>
    menu Encoding.koi8-r        :e ++enc=koi8-r<CR>
    menu Encoding.windows-1251  :e ++enc=cp1251<CR>
    menu Encoding.ibm-866       :e ++enc=ibm866<CR>
    menu Encoding.utf-8         :e ++enc=utf-8 <CR>
map <F8> :emenu Encoding.<TAB>


" Включаем мышку даже в текстовом режиме
" (очень удобно при копировании из терминала, т. к. без этой опции,
" например, символы табуляции раскладываются в кучу пробелов).
" set mouse=a

" Минимальная высота окна
set winminheight=0

" Минимальная ширина окна
set winminwidth=0

" Всегда отображать статусную строку для каждого окна
set laststatus=2

" Теперь нет необходимости передвигать курсор к краю экрана, чтобы подняться в
" режиме редактирования
set scrolljump=7
" Теперь нет необходимости передвигать курсор к краю экрана, чтобы опуститься 
" в режиме редактирования

set scrolloff=7

" Выключаем надоедливый звонок
set novisualbell
set t_vb=   

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 
set laststatus=2

" Заставляем shift-insert работать как в Xterm
map <S-Insert> <MiddleMouse>

set foldcolumn=1

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Размер табуляции
set tabstop=4
set softtabstop=4
set smarttab
set expandtab

" Размер сдвига при нажатии на клавиши << и >>
set shiftwidth=4

" Копирует отступ от предыдущей строки
set autoindent

" Включаем 'умную' автоматическую расстановку отступов
set smartindent

" Включаем подсветку синтаксиса
syntax on

" Включаем перенос строк
set wrap

" Перенос строк по словам, а не по буквам
set linebreak

" Включаем отображение выполняемой в данный момент команды в правом нижнем углу экрана.
" К примеру, если вы наберете 2d, то в правом нижнем углу экрана Vim отобразит строку 2d.
set showcmd

" Все swap файлы будут помещаться в эту папку
set dir=~/tmp/.swp

" ужасающих розовый цвет дефолтного окошка убираем
hi Pmenu ctermbg=239

set fileencodings=utf-8,cp1251,koi8-r,cp866
set termencoding=utf-8
set formatoptions=tcql
set helplang=ru
"set nu
set ruler
"set background=dark
set autoindent
"set foldmethod=indent
"set foldnestmax=1
colors desert
set ignorecase
set smartcase
set hlsearch
set incsearch
set listchars+=precedes:<,extends:>
set sidescroll=5
set sidescrolloff=5
set showmatch 
set history=500
filetype plugin on
filetype indent on
set undolevels=100
set ttyfast
set mousemodel=popup
"set hidden
set mousehide
let g:netrw_list_hide   = '\.pyc'
let g:proj_flags	= 'giSsTt'

let python_highlight_all=1

highlight Comment ctermfg=darkgrey

"imap {<CR> {<CR>}<Esc>O<Tab>
imap <C-Space> <C-N>
"nmap <Home> ^
"imap <Home> <Esc>I

" сохранить файл
imap <F2> <Esc>:w<CR>a
nmap <F2> :w<CR>

" сохранить все файлы
imap <S-F2> <Esc>:wa<CR>a
nmap <S-F2> :wa<CR>

" показать открытые буферы
imap <S-F4> <Esc>:buffers<CR>
nmap <S-F4> :buffers<CR>

" Удалить буфер
imap <C-F4> <Esc>:bd<CR>a
nmap <C-F4> :bd<CR>

" открыть проводник по файловой системе
nmap <F3> :execute 'NERDTreeToggle ' . getcwd()<CR>

"imap <Tab> <C-N>

" предыдущий буфер
nmap <F4> :bp<CR>
imap <F4> <ESC> :bp<CR>i<Right>

" следующий буфер
nmap <F5> :bn<CR>
imap <F5> <ESC> :bn<CR>i<Right>

" предыдущий буфер
nmap <M-Left> :bprev<CR>

"следующий буфер
nmap <M-Right> :bnext<CR>

"au BufWinEnter * let w:m1=matchadd('Search','\%<81v.\%>71v',-1)
"au BufWinEnter * let w:m2=matchadd('ErrorMsg','\%81v.*',-1)


function! TabWrapperRope()
  if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-R>=RopeCodeAssistInsertMode()\<CR>"
  endif
endfunction

"imap <Tab> <C-R>=TabWrapperRope()<CR>


"set complete=""
"set complete+=.
"set complete+=k
"set complete+=b
"set complete+=t
"set completeopt-=preview
"set completeopt+=longest


augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END



if version >= 700
"   По умолчанию проверка орфографии выключена.
    setlocal spell spelllang=
    setlocal nospell
    function ChangeSpellLang()
        if &spelllang =~ "en_us"
            setlocal spell spelllang=ru
            echo "spelllang: ru"
        elseif &spelllang =~ "ru"
            setlocal spell spelllang=
            setlocal nospell
            echo "spelllang: off"
        else
            setlocal spell spelllang=en_us
            echo "spelllang: en"
        endif
    endfunc

    " map spell on/off for English/Russian
    map <F11> <Esc>:call ChangeSpellLang()<CR>
endif


let NERDTreeIgnore=['\.pyc$', '\~$']
