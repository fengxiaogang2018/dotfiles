 
" help
"
" remap is an option that makes mappings work recursively
" map is recursive version version, works in normal visual, select and operator.
" noremap is non-recursive version.
" nmap works in normal mode.
" vmap works in visual mode.


"
" auto load for first time uses
"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



"
"外观
"
syntax on "开启语法高亮
set encoding=utf-8
set scrolloff=5 "确保程序上下都有5行
set number "显示行号
set relativenumber "显示相对行号
set cursorline "显示光标行
set wrap "自动折行
set showcmd "命令行显示输入命令
set wildmenu "底部命令补全
set listchars=tab:▸\ ,trail:■ "如果行尾有多余的空格（包括Tab键）,该配置将这些空格显示成可见的小方块。
set list



"
"缩进
"
set cindent
"能够很好的识别出C和Java等结构话程序语言，并能用C语言格式缩进来处理程序的缩进
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab "敲入tab时自动将其转化为空格



"
"搜索相关
"
set hlsearch 	"高亮搜索
set ignorecase 	"忽略大小写
set smartcase 	"只能匹配
set incsearch 	"动态搜索
noremap [ Nzz 	"匹配之后按[上一个 
noremap ] nzz	"匹配之后按]下一个 
noremap <LEADER><CR> :nohlsearch<CR> "按空格+回车取消高亮




"===
"=== Basic Mappings
"===

" Set <LEADER> as <SPACE>
let mapleader=" " "将前缀定义为空格

" Save & quit
noremap S :w<CR>
noremap Q :q<CR>

" Source vimrc file anytime
noremap R :source $MYVIMRC<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

"===
"=== Window management
"===

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
noremap cz <C-w>t<C-w>H "切换成垂直分屏
noremap sp <C-w>t<C-w>K "切换成水平分屏

" indentation
nnoremap < <<
nnoremap > >>

"===
"=== Tab management
"===

" Create a new tab with tn
noremap tn :tabe<CR>
noremap th :tabnext<CR>
noremap tl :tabprevious<CR>



" make Y to copy till the end of the line
nnoremap Y y$

"
" Cursor Movement
"
" J/K for 5 times j/k (faster navigation)
noremap J 5j
noremap K 5k

" H key:go to the start of the line
noremap H 0
" L key:go to the end of the line
noremap L $

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>


"===
"=== Other useful stuff
"===

" Opening a terminal window
noremap <LEADER>/ :term<CR>

" find and replace
noremap \s :%s//g<left><left>

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

"=
"= Install Plugins with Vim-Plug
"=

call plug#begin('~/.config/nvim/plugged')

Plug 'connorholyday/vim-snazzy'
Plug 'vim-airline/vim-airline'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Undo Tree
Plug 'mbbill/undotree'



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
noremap L :UndotreeToggle<CR>
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



" =============End of Plugint Settings ===============

"=
"= Necessary Commands to Execute
"=

exec "nohlsearch" 
