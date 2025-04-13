call plug#begin("~/.vim/plugged")

Plug 'dstein64/vim-startuptime' " :StartupTime

Plug 'ziglang/zig.vim'
Plug 'rluba/jai.vim'

Plug 'hrsh7th/nvim-cmp'                                     " autocomplete - LLM plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " better syntax highlighting, incremental selection, indentation
Plug 'nvim-treesitter/playground'                           " :TSPlaygroundToggle
Plug 'windwp/nvim-ts-autotag'                               " auto close html tags and ciw to change tags

Plug 'nvim-tree/nvim-web-devicons'                   " file explorer icons
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' } " file explorer
Plug 'kdheepak/lazygit.nvim'                         " lazygit integration
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/plenary.nvim'
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'otavioschwanck/arrow.nvim'         
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy search finder
Plug 'junegunn/fzf.vim'                             " fuzzy search finder

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

" --- Avante VIM ---
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'

" Optional deps
Plug 'hrsh7th/nvim-cmp'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'

Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
" --- Avante VIM ---

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
"set signcolumn=no  " keep gutter spacing always, use 'yes' to always show. THIS IS OVERRIDDEN BY GITGUTTER CONF
"set guicursor=     " disable insert mode cursor

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
set expandtab       " tabs as spaces
set tabstop=2 softtabstop=2 shiftwidth=2
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

" Tab navigation
nnoremap <silent> <Tab> gt
nnoremap <silent> <S-Tab> gT

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

" Sidebar Tree
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

lua require('mini.files').setup()
set splitright
set splitbelow

lua << EOF
  local minifiles_toggle = function()
    if not MiniFiles.close() then MiniFiles.open() end
  end

  vim.keymap.set({ 'n', 'v' }, ',', minifiles_toggle, { desc = 'Toggle MiniFiles' })
EOF

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

" CoC 
let g:coc_node_path = '/opt/homebrew/opt/node@20/bin/node'

" Rename CoC Action
noremap R <Plug>(coc-rename)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Use CTRL-L for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-l> <Plug>(coc-range-select)
xmap <silent> <C-l> <Plug>(coc-range-select)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Format
nnoremap <silent> <c-l> :Format<CR>

" GoTo code navigation
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <C-LeftMouse> <LeftMouse><Plug>(coc-definition)
nnoremap <silent> gs :call CocAction('jumpDefinition', 'vsplit')<cr>
nnoremap <silent> gt :call CocAction('jumpDefinition', 'tabe')<CR>
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(0) : "\<down>"
inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(0) : "\<up>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
\ <SID>check_back_space() ? "\<Tab>" :
\ "\<Tab>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter to complete
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" Run the Code Lens action on the current line.
" nmap <leader>cl <Plug>(coc-codelens-action)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> gE <Plug>(coc-diagnostic-prev)
nmap <silent> ge <Plug>(coc-diagnostic-next)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap ga <Plug>(coc-codeaction)
nmap ga <Plug>(coc-codeaction)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ga  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <M-C-S-Z> <Plug>(coc-fix-current)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

command FormatJson :%!jq .
command UnformatJson :%!jq -c .

"--------------------------------------------------------------

" dingllm
lua << EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },

    enabled = function()
      local context = require 'cmp.config.context'

      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture("comment") 
          and not context.in_syntax_group("Comment")
          and vim.bo.filetype ~= 'text'
          and vim.bo.filetype ~= 'txt'
      end
    end,
    
    mapping = cmp.mapping.preset.insert({
      ['<Right>'] = cmp.mapping.confirm({ select = true }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources({
      -- { name = 'llm_autocomplete' },
      { name = 'vsnip' },
      { 
        name = 'buffer', 
        entry_filter = function(entry, ctx)
          return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
        end
      },
    }),

    experimental = { 
      ghost_text = true 
    },
  })
EOF

lua << EOF

local system_prompt =
  'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks'
local helpful_prompt = 'You are a helpful assistant. If you\'re unsure about something, say so rather than guessing. Don\'t apologize.'
local dingllm = require 'dingllm'

local function handle_open_router_spec_data(data_stream)
  local success, json = pcall(vim.json.decode, data_stream)
  if success then
    if json.choices and json.choices[1] and json.choices[1].text then
      local content = json.choices[1].text
      if content then
        dingllm.write_string_at_cursor(content)
      end
    end
  else
    print("non json " .. data_stream)
  end
end

local function custom_make_openai_spec_curl_args(opts, prompt)
  local url = opts.url
  local api_key = opts.api_key_name and os.getenv(opts.api_key_name)
  local data = {
    prompt = prompt,
    model = opts.model,
    temperature = 0.7,
    stream = true,
  }
  local args = { '-N', '-X', 'POST', '-H', 'Content-Type: application/json', '-d', vim.json.encode(data) }
  if api_key then
    table.insert(args, '-H')
    table.insert(args, 'Authorization: Bearer ' .. api_key)
  end
  table.insert(args, url)
  return args
end

local function anthropic_help()
  dingllm.invoke_llm_and_stream_into_editor({
    url = "https://openrouter.ai/api/v1/chat/completions",
    model = "anthropic/claude-3.5-sonnet",
    api_key_name = 'ANTHROPIC_API_KEY',
    system_prompt = helpful_prompt,
    replace = false,
  }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end
local function anthropic_replace()
  dingllm.invoke_llm_and_stream_into_editor({
    url = "https://api.anthropic.com/v1/messages",
    model = "claude-3-5-sonnet-20241022",
    api_key_name = "ANTHROPIC_API_KEY",
    system_prompt = system_prompt,
    replace = true,
  }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end

local function openai_help_chatgpt_4o_latest()
 dingllm.invoke_llm_and_stream_into_editor({
   url = "https://api.openai.com/v1/chat/completions",
   model = "chatgpt-4o-latest",
   api_key_name = "OPENAI_API_KEY",
   system_prompt = helpful_prompt,
   replace = false,
 }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end
local function openai_replace_chatgpt_4o_latest()
   dingllm.invoke_llm_and_stream_into_editor({
     url = "https://api.openai.com/v1/chat/completions",
     model = "chatgpt-4o-latest",
     api_key_name = "OPENAI_API_KEY",
     system_prompt = system_prompt,
     replace = true,
   }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end

local function openai_help_o1_mini()
 dingllm.invoke_llm_and_stream_into_editor({
   url = "https://api.openai.com/v1/chat/completions",
   model = "o1-mini",
   api_key_name = "OPENAI_API_KEY",
   system_prompt = helpful_prompt,
   replace = false,
 }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end
local function openai_replace_o1_mini()
 dingllm.invoke_llm_and_stream_into_editor({
   url = "https://api.openai.com/v1/chat/completions",
   model = "o1-mini",
   api_key_name = "OPENAI_API_KEY",
   system_prompt = system_prompt,
   replace = true,
 }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end

local function gemini_flash_help()
 dingllm.invoke_llm_and_stream_into_editor({
   url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
   model = "gemini-2.0-pro-exp",
   api_key_name = "GEMINI_API_KEY",
   system_prompt = helpful_prompt,
   replace = false,
 }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end
local function gemini_flash_replace()
 dingllm.invoke_llm_and_stream_into_editor({
   url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
   model = "gemini-2.0-pro-exp",
   api_key_name = "GEMINI_API_KEY",
   system_prompt = system_prompt,
   replace = true,
 }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end

local function gemini_flash_thinking_help()
 dingllm.invoke_llm_and_stream_into_editor({
   url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
   model = "gemini-2.0-flash-thinking-exp",
   api_key_name = "GEMINI_API_KEY",
   system_prompt = helpful_prompt,
   replace = false,
 }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end
local function gemini_flash_thinking_replace()
 dingllm.invoke_llm_and_stream_into_editor({
   url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
   model = "gemini-2.0-flash-thinking-exp",
   api_key_name = "GEMINI_API_KEY",
   system_prompt = system_prompt,
   replace = true,
 }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
end

local function insert_new_lines_and_call(f)
  return function()
    if vim.fn.mode() == 'i' then  -- Check if in insert mode
      vim.cmd('stopinsert')  -- Exit insert mode
    end
    vim.api.nvim_put({'', ''}, 'l', true, true)  -- Insert two newlines below
    vim.cmd('normal! 2j')  -- Move cursor down twice
    f()
  end
end

vim.keymap.set({ "n", "v" }, "<leader>s", insert_new_lines_and_call(anthropic_help), { desc = "llm anthropic_help" })
vim.keymap.set({ "n", "v" }, "<leader>S", insert_new_lines_and_call(anthropic_replace), { desc = "llm anthropic_replace" })

vim.keymap.set({ "n", "v" }, "<leader>d", insert_new_lines_and_call(gemini_flash_help), { desc = "llm gemini_flash_help" })
vim.keymap.set({ "n", "v" }, "<leader>D", insert_new_lines_and_call(gemini_flash_replace), { desc = "llm gemini_flash_replace" })

vim.keymap.set({ "n", "v" }, "<leader>e", insert_new_lines_and_call(gemini_flash_thinking_help), { desc = "llm gemini_flash_thinking_help" })
vim.keymap.set({ "n", "v" }, "<leader>E", insert_new_lines_and_call(gemini_flash_thinking_replace), { desc = "llm gemini_flash_thinking_replace" })

vim.keymap.set({ "n", "v" }, "<leader>p", insert_new_lines_and_call(openai_help_chatgpt_4o_latest), { desc = "llm openai_help_chatgpt_4o_latest" })
vim.keymap.set({ "n", "v" }, "<leader>P", insert_new_lines_and_call(openai_replace_chatgpt_4o_latest), { desc = "llm openai_replace_chatgpt_4o_latest" })

vim.keymap.set({ "n", "v" }, "<leader>n", insert_new_lines_and_call(openai_help_o1_mini), { desc = "llm openai_help_o1_mini" })
vim.keymap.set({ "n", "v" }, "<leader>N", insert_new_lines_and_call(openai_replace_o1_mini), { desc = "llm openai_replace_o1_mini" })

vim.keymap.set({ "n", "v" }, "<leader>q", insert_new_lines_and_call(openai_help_o1_mini), { desc = "llm openai_help_o1_mini" })
vim.keymap.set({ "n", "v" }, "<leader>Q", insert_new_lines_and_call(openai_replace_o1_mini), { desc = "llm openai_replace_o1_mini" })

vim.keymap.set({ "n", "v" }, "<leader>w", insert_new_lines_and_call(openai_help_o1_mini), { desc = "llm openai_help_o1_mini" })
vim.keymap.set({ "n", "v" }, "<leader>W", insert_new_lines_and_call(openai_replace_o1_mini), { desc = "llm openai_replace_o1_mini" })


EOF

"--------------------------------------------------------------

" --- Avante VIM ---
autocmd! User avante.nvim lua << EOF

lua require('avante_lib').load()
lua require('avante').setup({provider = "openrouter", vendors = { openrouter = { __inherited_from = 'openai', endpoint = 'https://openrouter.ai/api/v1', api_key_name = 'OPENROUTER_API_KEY', model = 'anthropic/claude-3.5-sonnet', }, }, })

augroup mygroup
    autocmd!

    "autocmd FileType typescript,json,go setl formatexpr=CocAction('formatSelected')
    autocmd FileType java nnoremap <buffer> <M-C-S-D-R> :silent w<CR>:exec '!java' shellescape(@%, 1)<CR>
    "autocmd FileType jai  nnoremap <buffer> <M-C-S-D-R> :silent w<CR>:!jai % && ./main<CR>

    autocmd FileType jai nnoremap <buffer> <M-C-S-D-R> :silent w<CR>:call system('kitten @ send-key --match "title:^Output" up enter && kitty @ focus-window --match "title:^Output"')<CR>

    autocmd FileType c nnoremap <buffer> <M-C-S-D-R> :silent w<CR>:silent !make build run >/dev/null 2>&1 &<CR>

    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

    " Auto save on focus lost
    autocmd FocusLost * silent! :wa

    " autocmd BufNew,BufEnter *.txt execute "silent! CocDisable"
    " autocmd BufLeave *.txt execute "silent! CocEnable"
augroup end

