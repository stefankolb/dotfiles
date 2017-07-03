syntax on								" enable syntax processing
colorscheme molokai			" use molkai color scheme

set tabstop=2						" number of visual spaces per TAB character
set softtabstop=2				" number of spaces per TAB when editing
set expandtab						" use spaces instead of tabs

set number							" show line number
set showcmd							" show last executed command in bottom bar
set cursorline					" highlight current line
set wildmenu						" show visual autocomplete for command menu
set showmatch	 					" highlight matching paranthesis [{()}]
set ruler               " show row/col position

set incsearch						" search directly as characters are entered
set hlsearch						" highlight search matchesa
nnoremap <space><space> :nohlsearch<CR>

set foldenable					" enable folding
set foldlevelstart=10		" open first 10 fold levels by default
set foldnestmax=10			" 10 nested fold max
set foldmethod=indent		" use indentions as fold method

au FileType gitcommit set tw=72 " Auto-wrap git commit messages at 72 chars

set viminfo+=n~/.dotfiles/.viminfo  " Tell vim to store .viminfo here
