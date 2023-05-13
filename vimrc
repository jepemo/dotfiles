let g:vim_home_path = "~/.vim"

" General key remaps
nnoremap <SPACE> <Nop>
let mapleader = " "

" ============================================================================
" PLUGINS {{{
" ===========================================================================
" vim-plug: https://github.com/junegunn/vim-plug
call plug#begin()

" Lua utility functions
Plug 'nvim-lua/plenary.nvim'
" finder/picker/previewer/etc
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

" Look n feel
" Plug 'dracula/vim'
" Plug 'doums/darcula'
Plug 'elixir-editors/vim-elixir'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'

call plug#end()
" }}}


" Nerd - tree configuration
" Set the root directory to the parent of the current opened file
let g:NERDTreeChDirMode = 2 
:nnoremap <C-e> :NERDTreeToggle<CR>

" Nerdcommenter
filetype plugin on

