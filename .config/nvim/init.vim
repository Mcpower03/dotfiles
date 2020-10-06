" --- Mcpower03 Neovim Config ---


" Enables iMproved Features
set nocompatible
filetype off


"Vim Plug Auto Installer
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Call Vim Plug
call plug#begin('~/.vim/plugged')

"  Colors
"Polyglot Syntax Plugin
Plug 'sheerun/vim-polyglot'

"One Dark Colorscheme
Plug 'joshdick/onedark.vim'
"Dracula Colorscheme
Plug 'dracula/vim', { 'as': 'dracula' }
"Edge Colorscheme
Plug 'sainnhe/edge'
"Palenight Colorscheme
Plug 'drewtempelmeyer/palenight.vim'
"Challenger Deep Colorscheme
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
"Onehalf Colorscheme
Plug 'sonph/onehalf', {'rtp': 'vim/'}
"Colorscheme Pack
Plug 'flazz/vim-colorschemes'

"Status Line
"Lightline Status Bar Plugin
Plug 'itchyny/lightline.vim'

"Surround
Plug 'tpope/vim-surround'

"Nerd Tree
"Nerd Tree File Manager
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'xuyuanp/nerdtree-git-plugin'

"Language Stuff
"VSCode Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Syntax Checking Plugin
"Plug 'scrooloose/syntastic'

"Brackets
"Autopairs
Plug 'jiangmiao/auto-pairs'
"Rainbow Brackets Color Plugin
Plug 'luochen1990/rainbow'

"Indent Lines Indicators
Plug 'yggdroot/indentline'

"CtrlP
Plug 'ctrlpvim/ctrlp.vim'

"Icons
Plug 'ryanoasis/vim-devicons'

"Ends Vim Plug Call
call plug#end()

"Enables filetype detection
filetype plugin indent on

set encoding=UTF-8
set hidden
syntax on

" Disables Characters at end of line
set nolist

" Line Numbers
set number
set number relativenumber

" Tab Settings
"set expandtab
set autoindent
set softtabstop=8
set shiftwidth=8
set tabstop=8

"Enable Cursor Line
"set cursorline

"Enable mouse
set mouse=a

"Fix cursor replacement after closing nvim
set guicursor=

"Shift + Tab does inverse tab
inoremap <S-Tab> <C-d>

"Set a couple Search Options
set ic
set incsearch
set hlsearch
"Clear Highlight Search on Press Of Ctrl X
nmap <C-x> :nohlsearch<CR>

"Command Auto Complete Menu
set wildmenu
set wildmode=full

"Backup Settings
set nobackup
set nowritebackup
set noswapfile

"Disable Autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
   "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"Colorscheme Settings

"Enables Italics for Onedark Colorscheme
let g:onedark_terminal_italics=1
"Settings For Edge Colorscheme
let g:edge_style = 'neon'
"Italics For Palenight Colorscheme
let g:palenight_terminal_italics=1
"Sets colorscheme
colorscheme onedark

"Status Bar Settings

"Needed to get Lightline Status Bar
set laststatus=2
"Removes Showing of Mode Because Lightline Already Shows it
set noshowmode
"Sets Lightline Colorscheme
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \}

"NerdTree Stuff
nmap <C-n> :NERDTreeToggle<CR> 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"CtrlP Stuff
let g:ctrlp_working_path_mode = 'cra'
nmap <C-o> :CtrlP /<CR>
nmap <Leader>p :CtrlPBuffer<CR>
nmap <Leader>a :CtrlPMixed<CR>

"Buffer settings
"List Buffers On Press of Leader B
nnoremap <Leader>b :ls<CR>:buffer<Space>
"Close Buffers With Leader X
nnoremap <Leader>x :ls<CR>:bdelete<Space>

"Goyo (Relax Mode) Toggle
map <Leader>gy :Goyo<CR>

"Disable Enter Functionality Of Auto Pairs
let g:AutoPairsMapCR = 0

"COC Settings
"Goto Code Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
          " Recently vim can merge signcolumn and number column into one
            set signcolumn=number
    else
              set signcolumn=yes
      endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? replace me"\<C-n>" :
"      \ <SID>check_back_space() ? replace me"\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? replace me"\<C-p>" : replace me"\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

""See invisible characters
"set list listchars=tab:>\ ,trail:+,eol:$
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath=&runtimepath
"source ~/.vimrc
