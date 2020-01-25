"
" plug init
"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"map c a 在map生效的情况下，按下c就等同于按下了a
"noremap 不会递归的映射
"<C-A> ctrl + A
"set 设置的是选项
"let 设置的是变量


let mapleader=" " "将前缀定义为空格

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
set paste



"
"搜索相关
"
set hlsearch 	"高亮搜索
set ignorecase 	"忽略大小写
set smartcase 	"只能匹配
set incsearch 	"动态搜索
exec "nohlsearch" 
"进入vim时取消之前的搜索高亮
noremap [ Nzz 	"匹配之后按[上一个 
noremap ] nzz	"匹配之后按]下一个 
noremap <LEADER><CR> :nohlsearch<CR> "按空格+回车取消高亮


noremap J 5j
noremap K 5k



map S :w<CR> "保存
map Q :q<CR> "退出
map R :source $MYVIMRC<CR> "更新

map sl :set splitright<CR>:vsplit<CR> "右边分屏
map sh :set nosplitright<CR>:vsplit<CR> "左边分屏
map sj :set splitbelow<CR>:split<CR> "下边分屏
map sk :set nosplitbelow<CR>:split<CR> "上边分屏

map <LEADER>h <C-w>h 
map <LEADER>j <C-w>j 
map <LEADER>k <C-w>k 
map <LEADER>l <C-w>l 

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize -5<CR>
map <right> :vertical resize +5<CR>

map tn :tabe<CR>
map th :tabnext<CR>
map tl :tabprevious<CR>

map cz <C-w>t<C-w>H "切换成垂直分屏
map sp <C-w>t<C-w>K "切换成水平分屏


"
" plug
"
"

call plug#begin('~/.config/nvim/plugged')

Plug 'connorholyday/vim-snazzy'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"
"snazzy
"
colorscheme snazzy
let g:SnazzyTransparent = 1

"
" coc
"

" if hidden is not set, TextEdit might fail
set hidden

" Some servers have issues with backup files.
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 40000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

