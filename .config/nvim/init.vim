call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Mofiqul/vscode.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'numToStr/Comment.nvim'

" web
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'yaegassy/coc-tailwindcss3', {'do': 'yarn install --frozen-lockfile'}

" git
Plug 'airblade/vim-gitgutter'

call plug#end()

" basics
" color
set background=light
colorscheme vscode
hi MatchParen guifg=lightblue guibg=none
" syntax sync fromstart
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

set nonumber
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set showcmd
set wildmenu
set incsearch
set hlsearch
set smartindent
set nowrap
set mouse=a

let mapleader = "\<Space>"
vnoremap <leader>y "+y

" make netrw look ok
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" status line design
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" close buffer without destroying layout
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" show whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" cycle tabs
nnoremap <S-l> :tabnext<CR>
nnoremap <S-h> :tabprevious<CR>
nnoremap <leader>t :tabe<CR>

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" coc

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>


nnoremap <silent> <leader>d :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>o :<C-u>CocList outline<cr>
nmap <leader>.  <Plug>(coc-fix-current)
nnoremap <silent> <ESC><ESC> :nohlsearch \| match none \| 2match none \| call coc#float#close_all()<CR>

autocmd BufWritePre *.ts :silent call CocAction('runCommand', 'tsserver.sortImports')
autocmd BufWritePre *.tsx :silent call CocAction('runCommand', 'tsserver.sortImports')

" fzf
let $FZF_DEFAULT_COMMAND="rg --files --hidden"
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let g:fzf_layout = { 'down': '~90%' }
let g:fzf_preview_window = ['up:40%', 'ctrl-/']

" nerdtree
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" comment
lua << EOF
require('Comment').setup()
EOF

" git
nmap <leader>s <Plug>(GitGutterStageHunk)
nmap <leader>su <Plug>(GitGutterUndoHunk)

" sql
" when editing sql files don't remap ctrl c
let g:ftplugin_sql_omni_key = '<C-j>'

