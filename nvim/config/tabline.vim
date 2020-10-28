set tabline=%!MyTabLine()  " custom tab pages line

function MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		let [icon, iconHL] = TablineIconInfo(i + 1)

		" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%#BufferCurrentSign#'
		else
			let s .= '%#BufferInactiveSign#'
			let iconHL = 'BufferInactive'
		endif
		let s .= '▎'
		let s .= '%#' . iconHL . '#' . icon . ' '
		" let s .= '%#%{TablineIconColor(' . (i + 1) . ')}#'
		" let s .= '%{TablineIconColor(' . (i + 1) . ')}'
		" let s .= '%{TablineIcon(' . (i + 1) . ')}'
		if i + 1 == tabpagenr()
			let s .= '%#BufferCurrent#'
		else
			let s .= '%#BufferInactive#'
		endif

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'

" let g:lightline.separator = {'left': '', 'right': ''}
		" the label is made by MyTabLabel()
		let s .= '%{TablineName(' . (i + 1) . ')}'
		" let s .= '%t'

		let s .= '%{TablineModified(' . (i + 1) . ')} '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'

	" right-align the label to close the current tab page
	let s .= '%='
	if 1
		let s .= TablineCocStatus()
	end

	return s
endfunction

function MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	return bufname(l:bufnr)
endfunction

function! TablineModified(n)
	" return &modified ? '' : ''
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let l:filetype = getbufvar(l:bufnr, '&ft')
	let l:modified = getbufvar(l:bufnr, '&modified')
	let l:modifiable = getbufvar(l:bufnr, '&modifiable')
	return l:filetype ==# 'help' ? '' : l:modified ? '  ' : l:modifiable ? '' : ' '
endfunction

function! TablineName(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let l:name = bufname(l:bufnr)
	if empty(l:name)
		return '[No Name]'
	end
	return fnamemodify(l:name, ':t')
endfunction

lua << END
local web = require'nvim-web-devicons'
function get_icon_wrapper(args)
   local basename  = args[1]
   local extension = args[2]
   local icon, hl = web.get_icon(basename, extension, { default = true })
   return { icon, hl }
end
END

function! TablineIconInfo(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let l:name = bufname(l:bufnr)
	let basename = fnamemodify(l:name, ':t')
	let extension = matchstr(basename, '\v\.@<=\w+$', '', '')
	let [icon, hl] = luaeval("get_icon_wrapper(_A)", [basename, extension])
	if icon == ''
		let icon = g:icons.bufferline_default_file
	end
	return [icon, hl]
endfunc

function! TablineIcon(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let l:name = bufname(l:bufnr)
	let basename = fnamemodify(l:name, ':t')
	let extension = matchstr(basename, '\v\.@<=\w+$', '', '')
	let [icon, hl] = luaeval("get_icon_wrapper(_A)", [basename, extension])
	if icon == ''
		let icon = g:icons.bufferline_default_file
	end
	" return [icon, hl]
	return icon
endfunc

function! TablineIconColor(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let l:name = bufname(l:bufnr)
	let basename = fnamemodify(l:name, ':t')
	let extension = matchstr(basename, '\v\.@<=\w+$', '', '')
	let [icon, hl] = luaeval("get_icon_wrapper(_A)", [basename, extension])
	if icon == ''
		let icon = g:icons.bufferline_default_file
	end
	" return [icon, hl]
	return hl
endfunc

function! TablineCocStatus()
	let status = get(b:, 'coc_diagnostic_info', {})
	let c = '%#TablineSeparator#'
	if empty(status) | return c . '%#TablineSuccess#  ' | endif
	let error = status['error']
	let warning = status['warning']
	let info = status['information']
	let hint = status['hint']
	if get(status, 'hint', 0)
		let c .= '%#TablineSpecial# ﬤ ' . hint
	end
	if get(status, 'information', 0)
		let c .= '%#TablineInfo#  ' . info
	end
	if get(status, 'warning', 0)
		let c .= '%#TablineWarning#  ' . warning
	end
	if get(status, 'error', 0)
		let c .= '%#TablineError#  ' . error
	end
	if !(error + warning + info + hint)
		let c .= '%#TablineSuccess# '
	end
	return c . ' '
endfunc
