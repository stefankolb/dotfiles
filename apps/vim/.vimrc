" automatically load all bundles/plugins
execute pathogen#infect()

syntax on               " enable syntax processing

colorscheme gruvbox     " use gruvbox color scheme
set background=dark     " use gruvbox dark mode

set tabstop=2           " number of visual spaces per TAB character
set softtabstop=2       " number of spaces per TAB when editing
set expandtab           " use spaces instead of tabs

set number              " show line number
set cursorline          " highlight current line
set wildmenu            " show visual autocomplete for command menu
set showmatch           " highlight matching paranthesis [{()}]
set ruler               " show row/col position

set incsearch           " search directly as characters are entered
set hlsearch            " highlight search matchesa
nnoremap <space><space> :nohlsearch<CR>

set foldenable          " enable folding
set foldlevelstart=10   " open first 10 fold levels by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " use indentions as fold method

au FileType gitcommit set tw=72 " Auto-wrap git commit messages at 72 chars

set viminfo+=n~/.dotfiles/apps/vim/.viminfo   " Tell vim to store .viminfo here

let g:airline_theme='base16_gruvbox_dark_hard'    " Set airline theme

" shortcuts / key mappings
map <C-n> :NERDTreeToggle<CR>
