let $VIMRUNTIME=''
set termguicolors

" Vim UI {
  "set shell=/bin/sh
  set nocompatible            " be iMproved, required
  filetype off                " required
  filetype plugin indent on   " Automatically detect file types.
  set mousehide               " Hide the mouse cursor while typing
  scriptencoding utf-8

  set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
  "set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
  set history=1000                    " Store a ton of history (default is 20)
  set hidden                          " Allow buffer switching without saving

  "set iskeyword-=.                    " '.' is an end of word designator
  "set iskeyword-=#                    " '#' is an end of word designator
  "set iskeyword-=-                    " '-' is an end of word designator

  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
  " Restore cursor to file position in previous editing session
  function! ResCur()
      if line("'\"") <= line("$")
          normal! g`"
          return 1
      endif
  endfunction

  " Always restore the cursor when opening a buffer
  augroup resCur
      autocmd!
      autocmd BufWinEnter * call ResCur()
  augroup END

  " Setting up the directories {
  set backup                      " Backups are nice ...
  if has('persistent_undo')
      set undofile                " So is persistent undo ...
      set undolevels=1000         " Maximum number of changes that can be undone
      set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
  endif
" }

" Vim UI {
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    "set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    "if has('statusline')
        "set laststatus=2

        "" Broken down into easily includeable segments
        "set statusline=%<%f\                     " Filename
        "set statusline+=%w%h%m%r                 " Options
        "set statusline+=%{fugitive#statusline()} " Git Hotness
        "set statusline+=\ [%{&ff}/%Y]            " Filetype
        "set statusline+=\ [%{getcwd()}]          " Current dir
        "set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    "endif

    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }

" Formatting {
    set wrap                        " Do wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every four columns
    set softtabstop=2               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call CustomStripWhitespace()
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

    autocmd BufRead,BufNewFile *.go set filetype=go
    autocmd BufNewFile,BufRead *.jade set filetype=pug
    autocmd BufNewFile,BufRead *.ts set filetype=typescript
    autocmd BufNewFile,BufRead *.vue set filetype=vue

    autocmd BufNewFile,BufRead *.php set filetype=php noexpandtab

    autocmd FileType c,cpp,h setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
    autocmd BufNewFile,BufRead *.rs set filetype=rust

" }

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'posva/vim-vue'

" Python scratch pad
" Plugin 'metakirby5/codi.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'

" Better JS syntax highlighter
Plugin 'othree/yajs.vim'
" Plugin 'fleischie/vim-styled-components'
" Plugin 'mxw/vim-jsx'

Plugin 'hail2u/vim-css3-syntax'
Plugin 'itchyny/lightline.vim'
Plugin 'jacoborus/tender.vim'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'kchmck/vim-coffee-script'
Plugin 'airblade/vim-gitgutter'
Plugin 'Raimondi/delimitMate'

" Code completion
Plugin 'Valloric/YouCompleteMe'
Plugin 'ternjs/tern_for_vim'

" Themes
" Plugin 'NLKNguyen/papercolor-theme'
Plugin 'Gummybears'

Plugin 'fatih/vim-go'

" Enable JSX as well for the js files
let g:jsx_ext_required = 0

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Change the mapleader from / to ,
let mapleader=","

" Settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['standard', 'babel-eslint']
let g:syntastic_typescript_checkers = ['tslint']

let g:syntastic_javascript_checkers = []
autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc.js', '.;') !=# '' ? ['eslint'] : ['standard']

" Syntax highlighting
syntax on

" Remove trailing white spacing in the file
function! CustomStripWhitespace()
  if has("persistent_undo") && !empty(@%)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")

    %s/\s\+$//e
    exe "w"

    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
  endif
endfunction

" Always remove the whistespace if the following command is used
command! W call CustomStripWhitespace()

" Open up the netrw explorer if the key is pressed
noremap <leader>e :Explore<CR>

" For the sake of learning to get rid of bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Make up and down change the splits instead
nmap <Up> :res +1<CR>
nmap <Down> :res -1<CR>
nmap <Left> :vertical res -1<CR>
nmap <Right> :vertical res +1<CR>

" Fugitive shortcuts
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
" Mnemonic _i_nteractive
nnoremap <silent> <leader>gi :Git add -p %<CR>
nnoremap <silent> <leader>gg :SignifyToggle<CR>

" Set the colourscheme
set background=light
colorscheme tender
noremap <leader>1 :set background=dark<CR>:colorscheme gummybears<CR>
noremap <leader>2 :set background=light<CR>:colorscheme PaperColor<CR>
noremap <leader>3 :set background=dark<CR>:colorscheme PaperColor<CR>
noremap <leader>4 :set background=dark<CR>:colorscheme tender<CR>

" Initialize directories {
function! InitializeDirectories()
  let parent = $HOME
  let prefix = 'vim'
  let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }
  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  let common_dir = parent . '/.' . prefix

  for [dirname, settingname] in items(dir_list)
    let directory = common_dir . dirname . '/'
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction

" Make sure all our directories are where they belong
call InitializeDirectories()

" Set the default omnifunc
"set omnifunc=syntaxcomplete#Complete

" NeoVim true color
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Make sure that <ESC> is remapped to get out of the terminal
tnoremap <Esc> <C-\><C-n>

" Set the max line length indicator
set colorcolumn=110

" Enable the git gutter
let g:gitgutter_enabled = 1

" Ignore those blasted directories that keep me up at night
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|bower_components\|build\|dist\|tmp'
let g:ctrlp_show_hidden = 1

" badwolf settings
let g:colors_name = 'badwolf'
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 2
let g:badwolf_css_props_highlight = 1
let g:badwolf_html_link_underline = 1

" NetRw styling
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 3

" vim-mocha configuration
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>l :call RunLastSpec()<CR>

let g:mocha_js_command = "!ava {spec}"
"let g:mocha_js_command = "!mocha --no-colors --compilers js:babel-register {spec}"
let g:mocha_coffee_command = "!mocha --no-colors -b --compilers coffee:coffee-script/register --timeout 8000 --require coffee-script/register --check-leaks {spec}"

" Easier window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" JavaScript syntax highlighting
let g:javascript_plugin_jsdoc = 1

" YouCompleteMe settings
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

let g:ycm_global_ycm_extra_conf = "~/my-vim/_ycm_extra_conf.py"

let g:tender_lightline = 1
let g:lightline = {
      \ 'colorscheme': 'tender',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return ( fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '') )
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? ' ' . mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" Get copy/paste in through <C-c>
set clipboard=unnamed

set mouse=

set showmode

" Keybindings for js tern
noremap <leader>tt :TernType<CR>
noremap <leader>tr :TernRename<CR>
noremap <leader>te :TernRefs<CR>
noremap <leader>td :TernDef<CR>
noremap <leader>tf :TernDoc<CR>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Typescript errors appear in nested window
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
