nnoremap <silent> <space>t :call GotoBuffer(0)<CR>
nnoremap <silent> <space>T :call OpenBuffer(0)<CR>
nnoremap <silent> <C-t> :call ToggleBuffer(0)<CR>
tnoremap <silent> <C-t> <C-\><C-n>:call ToggleBuffer(0)<CR>
autocmd TermOpen * nnoremap <buffer><silent> <C-t> :call ToggleBuffer(0)<CR>
autocmd TermOpen * setlocal fillchars+=eob:\  nonumber norelativenumber nocursorline signcolumn=no
autocmd TermOpen * set nobuflisted
autocmd TermOpen * nnoremap <buffer> cc i<C-u>
autocmd TermOpen * nnoremap <buffer> S i<C-u>
autocmd BufWinEnter,WinEnter term://* set nobuflisted

" tnoremap <C-t> <C-\><C-n><C-w>c
" nmap <space>ta :call GotoBuffer(0)<CR>
" nmap <space>ts :call GotoBuffer(1)<CR>
" nmap <space>td :call GotoBuffer(2)<CR>
" nmap <space>tf :call GotoBuffer(3)<CR>

" nmap <space>tsa :call SetBuffer(0)<CR>
" nmap <space>tss :call SetBuffer(1)<CR>
" nmap <space>tsd :call SetBuffer(2)<CR>
" nmap <space>tsf :call SetBuffer(3)<CR>

" nmap <space>t<space> :call ReturnBuffer()<CR>

let g:win_ctrl_last_buf = 0
let g:win_ctrl_current_buf = 0
function! GotoBuffer(ctrlId)
	if (a:ctrlId > 9) || (a:ctrlId < 0)
		echo "CtrlID must be between 0 - 9"
		return
	endif

	let contents = g:win_ctrl_buf_list[a:ctrlId]
	if type(l:contents) != v:t_list
		let g:win_ctrl_last_buf = nvim_win_get_buf(0)
		terminal
		let g:win_ctrl_current_buf = nvim_win_get_buf(0)
		call SetBuffer(a:ctrlId)
		return
	endif

	let bufh = l:contents[1]
	let g:win_ctrl_last_buf = nvim_win_get_buf(0)
	let g:win_ctrl_current_buf = l:bufh
	call nvim_win_set_buf(0, l:bufh)
endfunction

let g:win_ctrl_buf_list = [0, 0, 0, 0]
function! SetBuffer(ctrlId)
	if has_key(b:, "terminal_job_id") == 0
		echo "You must be in a terminal to execute this command"
		return
	end
	if (a:ctrlId > 9) || (a:ctrlId < 0)
		echo "CtrlID must be between 0 - 9"
		return
	endif

	let g:win_ctrl_buf_list[a:ctrlId] = [b:terminal_job_id, nvim_win_get_buf(0)]
endfunction

function! ReturnBuffer()
	echo "return"
	let win_ctrl_last_buf = g:win_ctrl_last_buf
	let g:win_ctrl_last_buf = nvim_win_get_buf(0)
	let g:win_ctrl_current_buf = l:win_ctrl_last_buf
	call nvim_win_set_buf(0, l:win_ctrl_last_buf)
endfunction


let g:win_ctrl_buf_open = 0
function! OpenBuffer(ctrlId)
	80vsplit
	call GotoBuffer(a:ctrlId)
	startinsert
	let g:win_ctrl_buf_open = nvim_get_current_win()
endfunction

function! CloseBuffer(ctrlId)
	let g:win_ctrl_last_buf = nvim_win_get_buf(0)
	call nvim_win_close(g:win_ctrl_buf_open, 1)
	let g:win_ctrl_current_buf = nvim_win_get_buf(0)
	let g:win_ctrl_buf_open = 0
endfunction

function! ToggleBuffer(ctrlId)
	if g:win_ctrl_buf_open == 0
		call OpenBuffer(a:ctrlId)
	else
		call CloseBuffer(a:ctrlId)
	endif
endfunction

