let g:lightline = {
	\ 'colorscheme': 'better',
	\ 'subseparator': {'left': '', 'right': ''},
	\ 'separator': {'left': '', 'right': ''},
	\ 'active': {
		\ 'left': [
			\ ['mode', 'paste'],
			\ ['gitbranch'],
			\ ['filename', 'readonly', 'modified'],
			\ ['coc_status']
		\ ],
		\ 'right': [
			\ ['coc_errors', 'coc_warnings', 'coc_ok'],
			\ ['lineinfo'],
			\ ['percent'],
			\ ['filetype']
		\ ]
	\ },
	\ 'component': {
		\ 'helloworld': 'Hello, world!',
		\ 'charvaluehex': '0x%B',
	\ },
	\ 'component_function': {
		\ 'gitbranch': 'FugitiveHead',
		\ 'readonly': 'StatuslineReadonly',
		\ 'modified': 'StatuslineModified'
	\ },
	\ 'tabline': {
		\ 'right': [
			\ ['coc_errors', 'coc_warnings', 'coc_ok'],
		\ ]
	\ },
	\ 'tab': {
		\ 'active': ['filename', 'modified'],
		\ 'inactive': ['tabnum', 'filename', 'modified'],
	\ },
	\ 'component_type': {
		\ 'coc_ok': 'ok'
	\ },
	\ 'mode_mapd': {
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
	\ },
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

call lightline#coc#register()

