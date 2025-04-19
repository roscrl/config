call plug#begin("~/.vim/plugged")

Plug 'dstein64/vim-startuptime' " :StartupTime

Plug 'ziglang/zig.vim'
Plug 'rluba/jai.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " better syntax highlighting, incremental selection, indentation
Plug 'windwp/nvim-ts-autotag'                               " auto close html tags and ciw to change tags

" Tree Explorer
Plug 'kdheepak/lazygit.nvim' " lazygit integration

" Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
Plug 'BurntSushi/ripgrep '
Plug 'nvim-lua/plenary.nvim'

Plug 'otavioschwanck/arrow.nvim'         
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }

Plug 'AndrewRadev/splitjoin.vim'
Plug 'romainl/vim-cool'           " auto stop highlighting after done searching
Plug 'tpope/vim-surround'         " surround/change quotes tags
Plug 'tpope/vim-repeat'           " repeat with .
Plug 'vim-test/vim-test'          " test files easily
Plug 'junegunn/vim-easy-align'    " allow to create nice formatting alignments like shown
Plug 'farmergreg/vim-lastplace'   " remember cursor position on reopen should be able to remove on next neovim update 0.9

Plug 'windwp/nvim-autopairs'      " auto add ending braces/brackets upon open
Plug 'phaazon/hop.nvim'           " better jumps/changes around document
Plug 'terrortylor/nvim-comment'   " auto comment detection with gcc
Plug 'mbbill/undotree'            " easy view of files undo history
Plug 'rmagatti/auto-session'      " remember my session upon opening
Plug 'mg979/vim-visual-multi'     " multiple cursor selection <c-n>

" Avante VIM
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

Plug 'kvrohit/rasmus.nvim'                            " colorscheme
Plug 'https://gitlab.com/yorickpeterse/vim-paper.git' " colorscheme

call plug#end()

lua vim.loader.enable()

set termguicolors " required for full terminal color support 
colorscheme paper
let $BAT_THEME='Monokai Extended Light'
let g:fzf_colors =                                                                         
      \ { 'fg':      ['fg', 'Normal'],                                                           
      \ 'bg':      ['bg', 'Normal'],                                                           
      \ 'hl':      ['fg', 'Comment'],                                                          
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],                             
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],                                       
      \ 'hl+':     ['fg', 'Statement'],                                                        
      \ 'info':    ['fg', 'PreProc'],                                                          
      \ 'border':  ['fg', 'Ignore'],                                                           
      \ 'prompt':  ['fg', 'Conditional'],                                                      
      \ 'pointer': ['fg', 'Exception'],                                                        
      \ 'marker':  ['fg', 'Keyword'],                                                          
      \ 'spinner': ['fg', 'Label'],                                                            
      \ 'header':  ['fg', 'Comment'] } 

hi LineNr guifg=#6a6a69
hi MsgArea guifg=#545453

set clipboard=unnamedplus " share clipboard with system
set number                " add line numbers to gutter
set numberwidth=5         " make line numbers 4 characters wide
set mouse=ar              " allow mouse use
set autoread              " reload files that have not been modified
set backspace=2           " makes backspace behave like you'd expect
set splitright
set splitbelow

set laststatus=0 " one global statusline at bottom (not for each window)
set noruler
set noshowcmd
set noshowmode
set cmdheight=1  " hide cmd line when not in use, cmdheight 0 flickers
set shortmess=aAcCFIlmOortTW

set hidden       " keep files around in buffer after closing
set noerrorbells " dont play sound
set tw=0         " dont wrap at 80 columns by default
set scrolloff=6  " reaching top or bottom of screen is offset by 
set updatetime=300
set signcolumn=number

" Keep history
set noswapfile nobackup
set undodir=~/.vim/undodir
set undofile

" Search 
set hlsearch   " dont keep highlighting after searching
set incsearch  " while typing search command, incrementally show highlited results
set ignorecase " ignore case when searching with /
set smartcase  " dont ignore case if a caps letter is used while seraching

" Indentaton, also handled by treesitter
set expandtab " tabs as spaces
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent
set smartindent
set mousescroll=ver:1

let mapleader = " "

" Empty line above/below
nnoremap <M-C-S-D-K> mpO<esc>`p
nnoremap <M-C-S-D-j> mpo<esc>`p

nnoremap <M-C-S-E> :e 

" quick delete file and insert for llm
nnoremap <leader>c ggVGdi

" Search
nnoremap s /

nnoremap <C-i> <C-i>

" Tab to search after and before while searching
set wildcharm=<C-z>
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>zz/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>zz?<C-r>/" : "<S-Tab>"

" Rezising windows
nmap <S-D-l> <c-w><
nmap <S-D-h> <c-w>>
nmap <S-D-j> <c-w>-
nmap <S-D-k> <c-w>+

" Tab to tab lines in visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Insert mode quick remove one char ahead
inoremap <M-C-S-X> <c-o>x

" Delete behind as normal text editor
inoremap <c-Backspace> <c-o>db

" Insert mode quick delete line
inoremap <c-d> <c-o>dd

" Visual block mode right click
nnoremap <RightMouse> <LeftMouse><C-v>
vnoremap y may`a

" Tab indentation
nnoremap <silent> <Tab>   >>
nnoremap <silent> <S-Tab> <<

" Window navigation
nnoremap <Left> <C-w>h
nnoremap <Right> <C-w>l
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <silent> <M-C-S-U> :vs<bar>:b#<CR>
nnoremap <silent> <M-C-S-N> :sp<bar>:b#<CR>

" Select all
nnoremap <C-a> gg<S-v>G

" Swap dd to D
nnoremap D "_dd
nnoremap dd "_D

" Selecting to end of line should not include new line char
vnoremap $ $h

" Delete to not override paste clipboard using leader, keep paste clipboard on multiple paste.
nnoremap x "_x
nnoremap d "_d
vnoremap d "_d
nnoremap C "_C
vnoremap C "_C
nnoremap c "_c
vnoremap c "_c

" Allow paste in visual mode without losing paste again
xnoremap p pgvy
xnoremap P Pgvy

" Swap gg and G
nnoremap gg G
nnoremap G gg

" Line movement on multi select up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Yank full line to Y
nnoremap Y yy

" Make j and k move to the next row, not file line useful for when line wrapping occurs
nnoremap j gj
nnoremap k gk

" Disable highlighted search upon escape
nnoremap <silent> <esc> :noh<return><esc>

" Save 
noremap  <silent> <M-C-S-S> :w<CR>
inoremap <silent> <M-C-S-S> <Esc>:w<CR>a
vnoremap <silent> <M-C-S-S> <Esc>:w<CR>gv
noremap  <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <Esc>:w<CR>a
vnoremap <silent> <C-s> <Esc>:w<CR>gv

" Quit
nnoremap <silent> <C-x> :x<CR>
nnoremap <silent> <M-C-S-D> :x<CR>
nnoremap <silent> <C-1> :qa<CR>
nnoremap <silent> <C-q> :qa!<CR>

" Refresh .vimrc
nnoremap <leader><cr> :so ~/.config/nvim/init.vim<CR>

" dont use zt or zb so make common case on centering easier
nnoremap z zz

" Jump around searches while keeping screen centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Smart indent when entering insert mode with a on empty lines
function! IndentWithA()
	if len(getline('.')) == 0
		return "\"_cc"
	else
		return "a"
	endif
endfunction
function! IndentWithI()
	if len(getline('.')) == 0
		return "\"_cc"
	else
		return "i"
	endif
endfunction

nnoremap <expr> a IndentWithA()
nnoremap <expr> i IndentWithI()

"--------------------------------------------------------------

nnoremap <silent> <leader>l :call SwitchColorscheme()<cr>
function SwitchColorscheme()
  if g:colors_name == "paper"
    execute "silent !" . "sed -i '' -e '1s/colorscheme paper/colorscheme paper/;t' -e '1,/colorscheme paper/s//colorscheme rasmus/' /Users/ross/.config/nvim/init.vim"
    execute "silent !" . "kitty +kitten themes --reload-in=all Rasmus"
    " lua require('lualine').setup{ options = {icons_enabled = false, theme = 'auto' } }
    let $BAT_THEME='zenburn'
    colorscheme rasmus
  else
    execute "silent !" . "sed -i '' -e '1s/colorscheme rasmus/colorscheme paper/;t' -e '1,/colorscheme rasmus/s//colorscheme paper/' /Users/ross/.config/nvim/init.vim"
    execute "silent !" . "kitty +kitten themes --reload-in=all Paper"
    let $BAT_THEME='Monokai Extended Light'
    " lua require('lualine').setup{ options = {icons_enabled = false, theme = 'solarized_light'} }
    colorscheme paper
  endif
endfunction

" Vim Test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" Format
nnoremap <silent> <c-l> :Format<CR>

" Telescope
lua require('telescope').setup({ defaults = { mappings = { i = { ["<Esc>"] = require('telescope.actions').close } } }})

nnoremap <silent>f <cmd>Telescope find_files<cr>
nnoremap <silent>F <cmd>Telescope live_grep<cr>
nnoremap <silent><C-p> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Auto session
lua require('auto-session').setup {}
lua vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

" Arrow
lua require('arrow').setup({ leader_key=';' })

" LazyGit keybind
nnoremap <silent> <leader>g :LazyGit<CR>

" Hop
lua require('hop').setup()

nnoremap <silent> S :HopChar2<cr>
noremap t <cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>
noremap T <cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>
" since normal mode f and F are used for finding quickly but allow f & F in operator pending and visual mode
onoremap f <cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })<cr>
vnoremap f <cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })<cr>
onoremap F <cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>
vnoremap F <cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>

" Start interactive EasyAlign in visual mode (e.g. vipgn)
xmap gn <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gnip)
nmap gn <Plug>(EasyAlign)

" Auto fix ending {}
lua require("nvim-autopairs").setup {}

" Use Vgc for commenting out
lua require('nvim_comment').setup()

" Undo tree explorer
nnoremap <silent><M-C-S-D-'> :UndotreeToggle<cr>

" TreeSitter 
lua require('nvim-treesitter.configs').setup { indent = { enable = true } } 
lua require('nvim-treesitter.configs').setup { incremental_selection = { enable = true, keymaps = { init_selection = "<M-C-S-W>", node_incremental = "<M-C-S-W>", scope_incremental = "<M-C-S-B>", node_decremental = "<M-C-S-2>", }, }, }
lua require('nvim-treesitter.configs').setup { highlight = { enable = true, additional_vim_regex_highlighting = false, }, }
lua require('nvim-treesitter.configs').setup { autotag = { enable = true } }

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
nnoremap \c zc
nnoremap \a za
nnoremap \o zo
nnoremap \f zf

" Avante VIM
autocmd! User avante.nvim lua << EOF
lua require('avante_lib').load()
lua require('avante').setup({provider = "openrouter", vendors = { openrouter = { __inherited_from = 'openai', endpoint = 'https://openrouter.ai/api/v1', api_key_name = 'OPENROUTER_API_KEY', model = 'anthropic/claude-3.5-sonnet', }, }, })

augroup mygroup
    autocmd!

    autocmd FileType java nnoremap <buffer> <M-C-S-D-R> :silent w<CR>:exec '!java' shellescape(@%, 1)<CR>

    autocmd FileType jai nnoremap <buffer> <M-C-S-D-R> :silent w<CR>:call system('kitten @ send-key --match "title:^Output" up enter && kitty @ focus-window --match "title:^Output"')<CR>

    autocmd FileType c nnoremap <buffer> <M-C-S-D-R> :silent w<CR>:silent !make build run >/dev/null 2>&1 &<CR>

    " Auto save on focus lost
    autocmd FocusLost * silent! :wa
augroup end
