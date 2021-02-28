set nocompatible
let mapleader=','

call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround' "Work on text object, cs/ds/ys/yS/yss/ySs/ySS(Normal), S(Visual), C-s/C-sC-s(Insert)
"Plug 'kana/vim-textobj-user' "TODO
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"Plug 'easymotion/vim-easymotion' "<leader><leader>w, <leader><leader>f{char}
"Plug 'junegunn/fzf' "replace ctrlpvim/ctrlp.vim
"Plug 'junegunn/fzf.vim' "<Enter>/C-T/C-X/C-V	current window/new tab/horizontal split/vertical split
"Plug 'voidikss/vimfloaterm' "float terminal, like scratchpad for dwm
Plug 'msanders/snipmate.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/tagbar'
Plug 'junegunn/vim-easy-align' "powerful, TODO
call plug#end()

"noremap(no recursive), inoremap(insert mode), vnoremap(visual mode), nnoremap(normal mode)
"nnoremap j jzz
inoremap <C-d> <Del>
inoremap <C-k> <Esc><Right>d$a
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"nmap <leader>w :w !sudo -S tee %<CR>
nnoremap <leader>t :tabnew<space>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<CR>
nnoremap <leader>k :bufdo bd<CR>
"delete all buffers and edit last buffer, use \|(escape) or <bar>
nnoremap <leader>o :%bd\|e#<CR>
nnoremap <silent><Up> :resize +1<CR>
nnoremap <silent><Down> :resize -1<CR>
nnoremap <silent><Left> :vertical resize +1<CR>
nnoremap <silent><Right> :vertical resize -1<CR>

"Parenthesis, ()<Esc>i  or  ()<Left>
"inoremap /* /**<cr><space>*/<Esc>O*<space>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap [<CR> [<CR>]<ESC>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {<space> {  }<Left><Left>
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> > strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : strpart(getline('.'), col('.')-1, 1) == " " && strpart(getline('.'), col('.'), 1) == "}" ? "\<Right><Right>" : "}"
inoremap <expr> ` strpart(getline('.'), col('.')-1, 1) == "`" ? "\<Right>" : "`"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "'"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == '"' ? "\<Right>" : '"'
inoremap <expr> <bs> <sid>remove_pair()
imap <C-h> <bs>
"inoremap " ""<c-g>U<left> "auto insert double quote but fail in skipping
"or use text-obj to delete parenthesis, e.g. `C-o dab`

"Utils
nnoremap <leader>O O<Esc>O
nnoremap c "_c
nnoremap S :%s//g<Left><Left>
cnoremap W execute 'write !sudo tee % >/dev/null' <bar> setl nomodified
"com -bar w!! exe 'w !sudo tee >/dev/null %:p:S' | setl nomod

"Plugin
nmap <C-P> :FZF<CR>
nnoremap <Tab> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$', '__pycache__']
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"Use `:CocDiagnostics` to get all info
nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"let g:coc_user_config={}
"let g:coc_user_config['coc.preferences.jumpCommand'] = ':CocSplitIfNotOpen'
"command! -nargs=+ CocSplitIfNotOpen :call SplitIfNotOpen(<f-args>)
nmap <silent> gD :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

set path=.,src "fix gf for typescript
set suffixesadd=.js,.ts

set encoding=utf-8
set number
"set cursorline
set shiftwidth=2 tabstop=2 softtabstop=2
set textwidth=80
set noexpandtab "Don't expand tab to space
set wrap "No lines wrapping
set lbr "Linebreak on 200 characters
set tw=200
set ai si"Auto indent, Smart indent
set incsearch "Find the next match as we typing
set hlsearch
set ignorecase "Search
set smartcase "unless we type a capital
set magic "Search with regular expression
"set scrolloff=999
set nobackup
set noswapfile
set laststatus=2
set nomodeline
set history=200
set lazyredraw "Don't redraw while executing macros
set autoread "Reload file changed outside vim
"set whichwrap+=<,>,[,]
syntax on
filetype plugin indent on


"Disable auto comment insertion, check with ':set formatoptions?'
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
"Back to last position when opening
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"Delete all trailing whitespaces and newlines at the end of file on save
"autocmd BufWritePre * %s/\s\+$//e
"autocmd BufWritePre * %s/\n\+\%$//e
"autocmd BufWritePre *.[ch] %s/\%$/\r/e
"Run commands after change, as example:
"autocmd BufWritePost ~/repos/dwm/config.def.h !cd ~/repos/dwm/; sudo make install && { killall -q -9 dwm; setsid -f dwm }
"Auto create path when destination file/folder doesn't exist
augroup BWCCreatedir
	autocmd!
	autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


"Functions
function s:remove_pair() abort
	let pair = getline('.')[ col('.')-2 : col('.')-1 ]
	"echo '''''' ==> '' ('' equal \', while \ is not supported in vimscript str)
	return stridx('""''''()[]<>{}', pair) % 2 == 0 && len(pair) % 2 == 0 && col('.') > 1 ? "\<del>\<c-h>" : "\<bs>"
endfunction

function! SplitIfNotOpen(...)
	let fname=a:1
	let call=''
	if a:0 == 2 "Multi definition
		let fname=a:2
		let call=a:1
	endif
	let bufnum=bufnr(expand(fname))
	let winnum=bufwinnr(bufnum)
	if winum != -1
		exe winnum . "wincmd w"
	else
		exe "vsplit " . fname
	endif
	exe call
endfunction

function s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
		endif
	endif
endfunction

function! s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction
