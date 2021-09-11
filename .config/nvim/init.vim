 "--- namespace-miata Neovim Config ---


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
"Gruvbox
Plug 'morhetz/gruvbox'
"Colorscheme Pack
Plug 'flazz/vim-colorschemes'
"Monokai Themes
Plug 'patstockwell/vim-monokai-tasty'
Plug 'phanviet/vim-monokai-pro'
"Transparent
Plug 'kjwon15/vim-transparent'
"Pywal theme
Plug 'dylanaraps/wal.vim'

"Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Status Line
"Lightline Status Bar Plugin
"Plug 'itchyny/lightline.vim'
"Airline Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Surround
Plug 'tpope/vim-surround'

"Commenting
Plug 'tpope/vim-commentary'

"Nerd Tree
"Nerd Tree File Manager
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'xuyuanp/nerdtree-git-plugin'

"Language Stuff
"Syntax Checking Plugin
"Plug 'scrooloose/syntastic'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
"Brackets
"Autopairs
Plug 'jiangmiao/auto-pairs'
"Rainbow Brackets Color Plugin
Plug 'luochen1990/rainbow'

"Indent Lines Indicators
Plug 'yggdroot/indentline'

"Search
"CtrlP
Plug 'ctrlpvim/ctrlp.vim'

"Startup Screen
Plug 'mhinz/vim-startify'

"Colors
Plug 'norcalli/nvim-colorizer.lua'

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
map <C-x> :nohlsearch<CR>

"Command Auto Complete Menu
set wildmenu
set wildmode=full

"Backup Settings
set nobackup
set nowritebackup
set noswapfile

"Needed for colorizer
set termguicolors
"Colorizer Enable
lua require'colorizer'.setup()

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
"Gruvbox Theme Settings
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_contrast_light = 'soft'
"Monokai Theme Settings
let g:vim_monokai_tasty_italic = 1
"Sets colorscheme
colorscheme wal
"Airline Colorscheme
let g:airline_theme='base16_nord'
"Enables Rainbow Brackets
let g:rainbow_active = 1

"Status Bar Settings

"Needed to get Lightline Status Bar
set laststatus=2
"Removes Showing of Mode Because Lightline Already Shows it
set noshowmode
"Sets Lightline Colorscheme
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \}
"Airline Settings
"Enable tabline
let g:airline#extensions#tabline#enabled = 1
let airline#extensions#tabline#show_splits = 0
let airline#extensions#tabline#tabs_label = ''
"Disable tabline close button
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0
"Enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" Always show tabs
set showtabline=2
let g:webdevicons_enable_airline_tabline = 1

"Remap leader to space
let mapleader = ' '

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

"Git Stuff
let g:gitgutter_realtime = 1200
let g:gitgutter_map_keys = 0

"Buffer & Tab settings
"List Buffers On Press of Leader B
nnoremap <Leader>b :ls<CR>:buffer<Space>
"Close Buffers With Leader X
nnoremap <Leader>x :ls<CR>:bdelete<Space>
"Close Current Buffer with Leader D
nnoremap <Leader>d :bdelete!<CR>
"Move Between Buffers & Tabs with Leader H & L
map <Leader>L :tabn<CR>
map <Leader>H :tabp<CR>
map <Leader>l :bn<CR>
map <Leader>h :bp<CR>

"Split to the right instead of the left
set splitright
set splitbelow

"Terminal
map <C-w>tv :vsplit term://bash<CR>
map <Leader>vt :vsplit term://bash<CR>
map <C-w>ts :split term://bash<CR>
map <Leader>st :split term://bash<CR>
map <Leader>t :term<CR>
"Map ESC to exit insert mode for terminal
tnoremap <Esc> <C-\><C-n>

"Splits
map <Leader>v :vsplit<CR>
map <Leader>s :split<CR>
map <Leader>c :close<CR>

"Windows
" nmap <Leader>w <C-w>
" vmap <Leader>w <C-w>


"Save & Quit
nmap <Leader>q :q!<CR>
" map <Leader>w :w<CR>
" map <Leader>wq :wq<CR>
" map <Leader>e :w 


"Disable Enter Functionality Of Auto Pairs
let g:AutoPairsMapCR = 0

" Startify options
let g:startify_custom_header = [
	\ ' =================     ===============     ===============   ========  ======== ',
	\ ' \\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . // ',
	\ ' ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .|| ',
	\ ' || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . || ',
	\ ' ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .|| ',
	\ ' || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . || ',
	\ ' ||. . ||   ||-   || ||  `-||   || . .|| ||. . ||   ||-   || ||  `|\_ . .|. .|| ',
	\ ' || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . || ',
	\ ' ||_-  ||  .|/    || ||    \|.  || `-_|| ||_-  ||  .|/    || ||   | \  / |-_.|| ',
	\ ' ||    ||_-       || ||      `-_||    || ||    ||_-       || ||   | \  / |  `|| ',
	\ ' ||    `          || ||         `     || ||    `          || ||   | \  / |   || ',
	\ ' ||            .===  `===.         .=== .`===.         .===  /==. |  \/  |   || ',
	\ ' ||         .==    \_|-_ `===. .===    _|_   `===. .===  _-|/   `==  \/  |   || ',
	\ ' ||      .==     _-     `-_  `=     _-    `-_    `=   _-    `-_  /|  \/  |   || ',
	\ ' ||   .==     _-           `-__\._-          `-_./__-          `  |. /|  |   || ',
	\ ' ||.==     _-                                                      `  |  /==.|| ',
	\ ' ==     _-                         N E O V I M                         \/   `== ',
	\ ' \   _-                                                                 `-_   / ',
	\ '  ``                                                                       ``   ',
	\ ]

""Ugly CoC LSP Config
"" Use <c-space> to trigger completion.
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  elseif (coc#rpc#ready())
"    call CocActionAsync('doHover')
"  else
"    execute '!' . &keywordprg . " " . expand('<cword>')
"  endif
"endfunction

"" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

"" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder.
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)

"" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif

"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

"" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')

"" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Add (Neo)Vim's native statusline support.
"" NOTE: Please see `:h coc-status` for integrations with external plugins that
"" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Mappings for CoCList
"" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
