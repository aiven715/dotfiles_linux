setglobal nocompatible

""" For faster redraw
set ttyfast
" set lazyredraw

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-eunuch'
Plug 'w0rp/ale'
Plug 'justinmk/vim-dirvish'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'Buffers'] }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'mhartington/oceanic-next'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

call plug#end()

" Base settings
let mapleader = ','
set nonumber
set relativenumber
set updatetime=100
set nobackup
set noswapfile
set termguicolors
"set colorcolumn=78

" Color scheme
set background=dark
colorscheme oceanic

hi Normal guibg=none guifg='#CDD3DE'
hi LineNr guibg=bg
hi CursorLineNr guibg=bg guifg='#FAC863'
hi VertSplit guibg='#65737E' guifg='#000000'
hi EndOfBuffer guibg=bg guifg='#65737e'
hi CursorLine guibg='#1b2b34'
hi Directory guifg='#fac863'
hi StatusLine guibg=fg guifg='#0e171c'
hi StatusLineNC guibg='#4F5B66' guifg='#091013'
hi Whitespace guifg='#343D46'
hi NonText guifg='#343D46'
hi SignColumn guibg='#0e171c'
hi ALEErrorSign guibg='#0e171c'
hi ALEWarningSign guibg='#0e171c'
hi MatchParen gui=underline guibg=none
hi ColorColumn guibg='#0e171c'

" Invisible characters
set listchars=eol:¬,space:·,tab:--,trail:·,extends:>,precedes:<
set list

" Tabs
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

" Searching
set hlsearch
set incsearch
set noignorecase
set smartcase

" Statusline
function! FileTypeSL()
  let l:filetype = &ft

  return strlen(l:filetype) ? ' :: ' . l:filetype : ''
endfunction

" Causes cursor blinking in conjunction with ALE
function! GitBranchSL()
  let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return strlen(l:branchname) > 0 ? '[' . l:branchname . ']' : ''
endfunction

function! FileNameSL()
  let l:filepath = expand('%:p')
  let l:visible = 30
  let l:name = strlen(filepath) > l:visible ? "..." . strpart(l:filepath, strlen(l:filepath) - l:visible) : l:filepath

  return strlen(l:name) ? '‹‹ ' . l:name . ' ››' : l:name
endfunction

function! LinterErrSL() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error

  return l:all_errors != 0 ? '[' . l:all_errors . ']' : ''
endfunction

function! LinterWarnSL() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:all_non_errors != 0 ? '[' . l:all_non_errors . ']' : ''
endfunction

set laststatus=2
set statusline=
" set statusline+=\%{GitBranchSL()}
set statusline+=\ %{FileNameSL()}
set statusline+=\ %m
set statusline+=%=
set statusline+=\%#AleErrorSign#%{LinterErrSL()}%#StatusLine#
set statusline+=\%#AleWarningSign#%{LinterWarnSL()}%#StatusLine#
set statusline+=\ ‹‹
set statusline+=\ %p%%
set statusline+=\%{FileTypeSL()}
set statusline+=\ ››

" Fzf
map <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Ale
let g:ale_sign_error = '››'
let g:ale_javascript_eslint_executable = '.bin/eslint'

" Sign column
set signcolumn=yes

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Ruler
" set colorcolumn=80

" Terminal
nmap <leader>t :split<CR>:term<CR>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Prettier
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" Dirvish
let g:dirvish_mode = ':sort ,^.*[\/],'

" Vifm
" nnoremap <C-i> :EditVifm<CR>

" Go to definition
nnoremap <C-i> :ALEGoToDefinition<CR>

" CtrlSF
nmap <leader>f :CtrlSF<Space>
vmap <leader>f <ESC>:CtrlSF<Space><C-R><C-W><CR>
let g:ctrlsf_auto_close = {
    \ "normal" : 0,
    \ "compact": 0
    \}
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
let g:ctrlsf_mapping = {
    \ "next" : "",
    \ "prev" : "",
    \ }

" Emmet
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends': 'jsx',
\      'quote_char': "'",
\  },
\}
