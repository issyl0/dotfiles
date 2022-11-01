let mapleader = ','

call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'ervandew/supertab'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'github/copilot.vim'
  Plug 'jremmen/vim-ripgrep'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'miyakogi/conoline.vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'git submodule update --init --recursive' }
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'ojroques/vim-oscyank', {'branch': 'main'}
  Plug 'pwntester/octo.nvim'
  Plug 'sbdchd/neoformat'
  Plug 'scrooloose/nerdtree'
  Plug 'sebdah/vim-delve'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'vim-ruby/vim-ruby'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
call plug#end()

let g:neoformat_only_msg_on_error = 1

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "ruby" },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {}
  }
}

require'lualine'.setup {
  options = {
    theme = "nord"
  }
}

require'mason'.setup{}
require'mason-lspconfig'.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.sorbet.setup{
  cmd = { "bin/srb", "tc", "--lsp" }
}
EOF

augroup RemoveSpaces
  autocmd!
  autocmd BufWritePre *.md silent! :%s/\%u00A0/ /g
augroup end

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

vnoremap <leader>c :OSCYank<CR>
nmap <leader>o <Plug>OSCYank

cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq

let g:clipboard = {"name": "rdm", "copy": {}, "paste": {}}
let g:clipboard.copy["+"] = ["rdm", "copy"]
let g:clipboard.paste["+"] = ["rdm", "paste"]
let g:clipboard.copy["*"] = ["rdm", "copy"]
let g:clipboard.paste["*"] = ["rdm", "paste"]

nmap <leader>f :set hlsearch<cr>:Rg<space>
nmap <leader>n :NERDTreeToggle<CR>
nmap <Leader>r :NERDTreeFocus<cr> \| R

set background=dark
set tabstop=2
set belloff=all
set softtabstop=2
set expandtab
set shiftwidth=2
set autoindent
set mouse=a
set number
set completeopt=longest,menuone
set showcmd
set ruler
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set textwidth=80
set cmdheight=2
set updatetime=300
set shortmess+=c
