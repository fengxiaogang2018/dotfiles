

"
" System
"
let &t_ut=''
set autochdir


"
" Editor behavior
"
syntax on
set encoding=utf-8
set scrolloff=5
set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu
set listchars=tab:▸\ ,trail:■
set list
set cindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab
set splitright
set splitbelow
set updatetime=100

"
"搜索相关
"
set hlsearch
set ignorecase
set smartcase
set incsearch
noremap <LEADER><CR> :nohlsearch<CR>




"===
"=== Basic Mappings
"===

" Set <LEADER> as <SPACE>
let mapleader=" "

" Save & quit
noremap S :w<CR>
noremap Q :q<CR>

" Source vimrc file anytime
noremap R :source $MYVIMRC<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Open Starify
map <LEADER>st :Startify<CR>

" Find two consecutive identical characters
map <space>fw /\(\<\w\+\>\)\_s*\1


"===
"=== Window management
"===

" Disabling the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left(vertical),right(vertical)
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>


" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>h <C-w>h
noremap <LEADER>j <C-w>j
noremap <LEADER>k <C-w>k
noremap <LEADER>l <C-w>l

" Resize splits with arrow keys
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize -5<CR>
map <right> :vertical resize +5<CR>

" Place the two screens
noremap cz <C-w>t<C-w>H
noremap sp <C-w>t<C-w>K



"===
"=== Tab management
"===

" Create a new tab with tn
noremap tn :tabe<CR>
noremap th :tabnext<CR>
noremap tl :tabprevious<CR>

"=
"= Cursor Movement
"=
" J/K for 5 times j/k (faster navigation)
noremap J 5j
noremap K 5k
noremap W 5w
noremap B 5b

" H key:go to the start of the line
noremap H 0
" L key:go to the end of the line
noremap L $

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>


"===
"=== Other useful stuff
"===

" indentation
nnoremap < <<
nnoremap > >>

" find and replace
noremap <leader>r :%s//g<left><left>


" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'sh'
		:!time bash %
	endif
endfunc

" Opening a terminal window
map <LEADER>t :set splitbelow<CR>:sp<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4i

" Spelling Check with <space>sc
map <LEADER>sc :set spell!<CR>

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" Call figlet
map tx :r !figlet

"=
"= Install Plugins with Vim-Plug
"=

call plug#begin('~/.config/nvim/plugged')

" snazzy
Plug 'connorholyday/vim-snazzy'

" airline
Plug 'vim-airline/vim-airline'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Other visual enhancement
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'

" Undo Tree
Plug 'mbbill/undotree'

" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf.vim'


" Taglist
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }


" Markdown
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'dkarter/bullets.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install' }

call plug#end()

" =============Start of Plugint Settings ===============


"
" snazzy
"
colorscheme snazzy
let g:SnazzyTransparent = 1



"
" Coc
"

" if hidden is not set, TextEdit might fail
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':vervos imap <tab>' to make sure tab is not mapped by other
" plugin.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"
" Undotree
"
noremap <leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> u <plug>UndotreeNextState
	nmap <buffer> e <plug>UndotreePreviousState
	nmap <buffer> U 5<plug>UndotreeNextState
	nmap <buffer> E 5<plug>UndotreePreviousState
endfunc

"
" NERDTree
"
map <leader>n :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = "H"
let NERDTreeMapUpdirKeepOpen = "h"
let NERDTreeMapOpenSplit = ""
let NERDTreeMapOpenVSplit = "L"
let NERDTreeMapActivateNode = "l"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapOpenInTabSilent = "O"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = ""
let NERDTreeMapChangeRoot = "s"
let NERDTreeMapMenu = ","
let NERDTreeMapToggleHidden = "a"


"
" NERDTree-git
"
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" ===
" === Taglist           " 代码文件结构
" ===
map <silent> t :TagbarOpenAutoClose<CR>

" ===
" === FZF
" ===
map <leader>f :FZF<CR>



" ===
" === Startify
" ===
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]


" ===
" === indentLine 缩进线
" ===
let g:indentLine_char = '│'
let g:indentLine_color_term = 238
let g:indentLine_color_gui = '#333333'
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig


" ===
" === vim-table-mode
" ===
map <LEADER>tm :TableModeToggle<CR>




" ===
" === Bullets.vim
" ===
let g:bullets_set_mappings = 0


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'google-chrome'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

nmap <leader>mp <Plug>MarkdownPreview

" =============End of Plugint Settings ===============

"=
"= Necessary Commands to Execute
"=

exec "nohlsearch" 
