let g:vim_home_path = "~/.vim"

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
Plug 'dracula/vim'

call plug#end()
" }}}
