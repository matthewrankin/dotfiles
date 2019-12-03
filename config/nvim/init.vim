packadd minpac
if !exists('*minpac#init')
	" minpac is not available.
	" Settings for plugin-less environment.
else
	" minpac is available.
	call minpac#init({'verbose': 3})
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	" Additional plugins installed here.
	call minpac#add('junegunn/fzf')
	call minpac#add('junegunn/fzf.vim')
	call minpac#add('dense-analysis/ale')
	call minpac#add('pangloss/vim-javascript')
	call minpac#add('tpope/vim-fugitive')
	call minpac#add('airblade/vim-gitgutter')
	call minpac#add('vim-airline/vim-airline')
	call minpac#add('vim-airline/vim-airline-themes')
	call minpac#add('scrooloose/nerdtree')
  call minpac#add('sheerun/vim-polyglot', {'branch': 'release'})
	call minpac#add('burner/vim-svelte')
	call minpac#add('posva/vim-vue')
	call minpac#add('elzr/vim-json')
	call minpac#add('junegunn/vim-slash')
  call minpac#add('majutsushi/tagbar')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('neoclide/coc.nvim')
  call minpac#add('fatih/vim-go')

	" minpac utility commands
	command! PackUpdate call minpac#update()
	command! PackClean call minpac#clean()
	command! PackStatus call minpac#status()
endif

let mapleader = ","
set number
set relativenumber
set ignorecase
nnoremap <C-p> :<C-u>FZF<CR>

" Configure NERDTree
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
autocmd VimEnter * NERDTree | wincmd p

" Configure Terminal Mode
if has('nvim')
	tnoremap <Esc> <C-\><C-n>
	tnoremap <C-v><Esc> <Esc>
	" highlight! link TermCursor Cursor
	" highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

""""""""""""""""""""""""""""""""""""""""""
" Whitespace
""""""""""""""""""""""""""""""""""""""""""
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set list
set listchars=tab:\ \ ,trail:.,nbsp:+,extends:>,precedes:<
set nowrap
" The following line isn't necessary (I think), since I'm using vim-polyglot.
"au Filetype python setlocal tabstop=4 shiftwidth=4

""""""""""""""""""""""""""""""""""""""""""
" gitgutter setup
""""""""""""""""""""""""""""""""""""""""""
set updatetime=200

""""""""""""""""""""""""""""""""""""""""""
" ALE setup
""""""""""""""""""""""""""""""""""""""""""
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 0
let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
let g:ale_linters = {'svelte': ['stylelint', 'eslint']}
let g:ale_fixers = {
\	'javascript': ['prettier', 'eslint'],
\	'css': ['prettier'],
\	'svelte': ['prettier'],
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:airline#extensions#ale#enabled = 1
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

autocmd BufEnter * :syntax sync fromstart

""""""""""""""""""""""""""""""""""""""""""
" Go setup
""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
let g:go_fmt_command = 'goimports'
let g:go_auto_type_info = 1
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

""""""""""""""""""""""""""""""""""""""""""
" CoC setup
""""""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Navigate snippet placeholders using tab
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Use enter to accept snippet expansion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
