:set paste
:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set undofile

call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive' 
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'simnalamburt/vim-mundo'
Plug 'farmergreg/vim-lastplace'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-startify'

call plug#end()

" Yank to clipboard
noremap <leader>y "+y

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif

" show substitutions incrementally
if has("nvim")
	set inccommand=nosplit
endif
