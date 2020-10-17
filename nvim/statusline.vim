let g:lightline = {}
let g:lightline.colorscheme = 'better'
let g:lightline.separator = {'left': '', 'right': ''}
let g:lightline.subseparator = {'left': '', 'right': ''}

let g:lightline.component_type = {'coc_ok': 'ok'}
let g:lightline.component_function = {
	\ 'gitbranch': 'FugitiveHead',
	\ 'readonly': 'StatuslineReadonly',
	\ 'modified': 'StatuslineModified',
	\ 'fileicon': 'StatuslineFileIcon'
\ }
let g:lightline.tab_component_function = {'modified': 'TablineModified', 'fileicon': 'TablineFileIcon'}

let g:lightline.active = {
	\ 'left': [
		\ ['mode', 'paste'],
		\ ['gitbranch'],
		\ ['filename', 'readonly', 'modified'],
		\ ['coc_status']
	\ ],
	\ 'right': [
		\ ['lineinfo'],
		\ ['percent', 'charvaluehex'],
		\ ['filetype']
	\ ]
\ }

let g:lightline.tabline = {
	\ 'right': [
		\ ['coc_errors', 'coc_warnings', 'coc_ok'],
	\ ]
\ }

let g:lightline.tab = {
	\ 'active': ['fileicon', 'filename', 'modified'],
	\ 'inactive': ['tabnum', 'fileicon', 'filename', 'modified'],
\ }

let g:lightline.mode_mapd = {
	\ 'n' : '',
	\ 'i' : '',
	\ 'R' : 'R',
	\ 'v' : 'V',
	\ 'V' : 'VL',
	\ "\<C-v>": 'VB',
	\ 'c' : 'C',
	\ 's' : 'S',
	\ 'S' : 'SL',
	\ "\<C-s>": 'SB',
	\ 't': 'T',
\ }

set showtabline=2

" let g:lightline#coc#indicator_ok = ''
" let g:lightline#coc#indicator_warnings = ' '
" let g:lightline#coc#indicator_errors = ''

" let g:lightline#coc#indicator_ok = ''
" let g:lightline#coc#indicator_warnings = ' '
" let g:lightline#coc#indicator_errors = ''

let g:lightline#coc#indicator_ok = ''
let g:lightline#coc#indicator_warnings = '𥉉'
let g:lightline#coc#indicator_errors = ' '

function! StatuslineReadonly()
	return &readonly && &filetype !=# 'help' ? '' : ''
endfunction

function! StatuslineModified()
	" return &modified ? '' : ''
	return &ft ==# 'help' ? '' : &modified ? '' : &modifiable ? '' : ''
endfunction

function! TablineModified(n)
	" return &modified ? '' : ''
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let l:filetype = getbufvar(l:bufnr, '&ft')
	let l:modified = getbufvar(l:bufnr, '&modified')
	let l:modifiable = getbufvar(l:bufnr, '&modifiable')
	return l:filetype ==# 'help' ? '' : l:modified ? '' : l:modifiable ? '' : ''
endfunction

function! StatuslineFileIcon()
	return GetFileIcon(&ft)
endfunction

function! TablineFileIcon(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	return GetFileIcon(getbufvar(l:bufnr, '&ft'))
endfunction

function! GetFileIcon(ft)
	let l:icons = {
		\ 'html': [''],
		\ 'typescript': ['', 'ﯤ'],
		\ 'javascript': ['', ''],
		\ 'javascriptreact': [''],
		\ 'typescriptreact': [''],
		\ 'css': [''],
		\ 'markdown': [''],
		\ 'vim': [''],
		\ 'json': [''],
		\ 'default': ['', '', '']
	\ }
	return has_key(l:icons, a:ft) ? l:icons[a:ft][0] : l:icons.default[0]
endfunction

call lightline#coc#register()

