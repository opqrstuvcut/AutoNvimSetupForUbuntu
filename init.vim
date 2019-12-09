    call dein#add( 'nanotech/jellybeans.vim')
    call dein#add( 'thinca/vim-quickrun')  
    call dein#add( 'scrooloose/nerdtree')
    call dein#add( 'opqrstuvcut/vim-pydocstring')
    call dein#add('Shougo/vimproc', {'build': 'make'})
    call dein#add('tpope/vim-fugitive')
    call dein#add("airblade/vim-gitgutter")
    call dein#add("kana/vim-operator-user")
    call dein#add("rhysd/vim-operator-surround")
    call dein#add("opqrstuvcut/sonictemplate-vim.git")
    call dein#add("vim-airline/vim-airline")
    call dein#add("vim-airline/vim-airline-themes")
    call dein#add("bfredl/nvim-miniyank")
    call dein#add("thinca/vim-qfreplace")
    call dein#add('neoclide/coc.nvim', {'merge':0, 'build': './install.sh nightly'})
    call dein#add("Lokaltog/vim-easymotion")
    call dein#add("Shougo/denite.nvim")
    call dein#add("mbbill/undotree")
    call dein#add("simeji/winresizer")
    call dein#add('alvan/vim-closetag')

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax on

set number
set laststatus=2
set shiftwidth=4
set cursorline
hi clear CursorLine
inoremap <silent> jj <ESC>
nnoremap Y y$
set display=lastline
set t_Co=256
set hlsearch
set encoding=utf8
set fenc=utf-8
colorscheme jellybeans 
autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

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

set nocompatible
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
set clipboard+=unnamedplus

set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" =======================================
" operator suuround
" =======================================
" 目印行を常に表示する
if exists('&signcolumn')  " Vim 7.4.2201
    set signcolumn=yes
else
    let g:gitgutter_sign_column_always = 1
endif

" =======================================
" operator suuround
" =======================================
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

" =======================================
" QuickFix
" =======================================
autocmd QuickFixCmdPost *grep* cwindow
nnoremap [q :cprevious<CR>   " prev
nnoremap ]q :cnext<CR>       " before
nnoremap [Q :<C-u>cfirst<CR> " top
nnoremap ]Q :<C-u>clast<CR>  " bottom
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" =======================================
" Nerdtree
" =======================================
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" =======================================
" Airline
" =======================================
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme="molokai"

" =======================================
" miniyank
" =======================================
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" =======================================
" CocVim
" =======================================
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
nmap <silent> gd :vsp<CR><Plug>(coc-definition)
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

" =======================================
" EasyMotion
" =======================================
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)

" =======================================
" 文字検索のヒット数の表示
" =======================================
nnoremap <expr> / _(":%s/<Cursor>/&/gn")

function! s:move_cursor_pos_mapping(str, ...)
    let left = get(a:, 1, "<Left>")
    let lefts = join(map(split(matchstr(a:str, '.*<Cursor>\zs.*\ze'), '.\zs'), 'left'), "")
    return substitute(a:str, '<Cursor>', '', '') . lefts
endfunction

function! _(str)
    return s:move_cursor_pos_mapping(a:str, "\<Left>")
endfunction

" =======================================
" undotree
" =======================================
if has("persistent_undo")
    set undodir=$HOME."/.undodir"
    set undofile
endif

" =======================================
" winresizer
" =======================================
let g:winresizer_start_key = '<C-s>'

" =======================================
" closetag
" =======================================
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
