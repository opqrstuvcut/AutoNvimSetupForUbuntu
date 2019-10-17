if has('python3')
endif

set tabstop=4
set expandtab

"dein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=HOMEPATH/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('HOMEPATH/.cache/dein')
    call dein#begin('HOMEPATH/.cache/dein')

    " Let dein manage dein
    " Required:
    call dein#add('HOMEPATH/.cache/dein/repos/github.com/Shougo/dein.vim')

    call dein#add( 'nanotech/jellybeans.vim')
    call dein#add( 'Shougo/unite.vim')
    call dein#add( 'thinca/vim-quickrun')  
    call dein#add( 'scrooloose/nerdtree')
    " call dein#add( 'scrooloose/syntastic')
    call dein#add( 'w0rp/ale')
    call dein#add( 'opqrstuvcut/vim-pydocstring')
    " call dein#add( 'cjrh/vim-conda')
    call dein#add('Shougo/neocomplete.vim') " vimの補完機能
    " call dein#add('Shougo/vimproc', {'build': 'make'})
    call dein#add('tpope/vim-fugitive')
    call dein#add("airblade/vim-gitgutter")
    call dein#add("kana/vim-operator-user")
    call dein#add("rhysd/vim-operator-surround")
    call dein#add("opqrstuvcut/sonictemplate-vim.git")
    call dein#add("vim-airline/vim-airline")
    call dein#add("vim-airline/vim-airline-themes")
    call dein#add("bfredl/nvim-miniyank")
    " call dein#add('itchyny/lightline.vim')
    " call dein#add('maximbaz/lightline-ale')
    " call dein#add('delphinus/lightline-delphinus')
    call dein#add("thinca/vim-qfreplace")
    call dein#add('neoclide/coc.nvim', {'merge':0, 'build': './install.sh nightly'})
    "call dein#add('neoclide/coc.nvim', {'merge':0, 'build': 'yarn install --frozen-lockfile'})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

set number
set laststatus=2
set shiftwidth=4
set cursorline
hi clear CursorLine

" 目印行を常に表示する
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

syntax on

let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

if has('syntax')
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * call s:StatusLine('Enter')
        autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
    if a:mode == 'Enter'
        silent! let s:slhlcmd = 'highlight ' .s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    else
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
endfunction

"function! s:GetHighlight(hi)
"    redir => hl
"    exec 'highlight '.a:hi
"    redir END let hl = substitute(hl,'[\r\n]', '', 'g')
"    let hl = substitute(hl,'xxx', '', '')
"    return hl
"endfunction

" au FileType qf nnoremap <silent><buffer>q :quit<CR>
" let g:quickrun_no_default_key_mappings = 1
" nnoremap qr :cclose<CR>:write<CR>:QuickRun -mode n<CR>
" xnoremap qr :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
" nnoremap qe :<C-u>bw! \[quickrun\ output\]<CR>
" let g:quickrun_config = get(g:, 'quickrun_config', {})
" :set splitright
"let g:quickrun_config={'_': {'split': 'vertical',  'runner'    : 'vimproc',  'outputter/error/error'   : 'quickfix',  'outputter/buffer/close_on_empty' : 1,  'outputter/error/success' : 'buffer', 'runner/vimproc/updatetime' : 60}}
"let g:quickrun_config={'_': {'split': 'vertical',  'outputter/error/error'   : 'quickfix',  'outputter/buffer/close_on_empty' : 1,  'outputter/error/success' : 'buffer'}}
set nocompatible
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
set clipboard+=unnamedplus

inoremap <silent> jj <ESC>
nnoremap Y y$
set display=lastline
set t_Co=256
colorscheme jellybeans 
set hlsearch

autocmd QuickFixCmdPost *grep* cwindow
nnoremap [q :cprevious<CR>   " prev
nnoremap ]q :cnext<CR>       " before
nnoremap [Q :<C-u>cfirst<CR> " top
nnoremap ]Q :<C-u>clast<CR>  " bottom
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" let g:jedi#auto_initialization = 1
" let g:jedi#auto_vim_configuration = 1
" 
" let g:jedi#completions_command = "<C-Space>"    
" let g:jedi#goto_assignments_command = "<C-g>"   
" let g:jedi#goto_definitions_command = "<C-f>"  
" let g:jedi#documentation_command = "<C-k>"    
" let g:jedi#rename_command = "<Leader>j"
" let g:jedi#usages_command = "<Leader>n"
" let g:jedi#popup_on_dot = 0
" let g:jedi#use_splits_not_buffers = "right"


autocmd FileType python setlocal completeopt-=preview

"nerdtree short cut
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let g:ale_lint_on_text_changed = 1
let b:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {
      \ 'python': ['autopep8'],
      \ 'markdown': [
      \   {buffer, lines -> {'command': 'textlint -c ~/.config/textlintrc -o /dev/null --fix --no-color --quiet %t', 'read_temporary_file': 1}}
      \   ],
      \ }
let g:ale_fix_on_save = 1
let g:ale_sign_error = '☓'
let g:ale_sign_warning = '▲'

set encoding=utf8
set fenc=utf-8

set laststatus=2

autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme="molokai"
"let g:airline#extensions#tabline#buffer_idx_mode = 1
"let g:airline#extensions#tabline#enabled = 1
"
let g:ale_python_flake8_options="--max-line-length 120"
let g:ale_python_autopep8_options="--max-line-length 120"

map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)


" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

nmap qr :execute "CocCommand python.execInTerminal" <CR>
nmap se :execute "CocCommand python.setInterpreter" <CR>

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ファイルを開いたときに前回のカーソル位置で開く
augroup KeepLastPosition
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END
