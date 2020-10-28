set tabline=%!MyTabLine()  " custom tab pages line

function MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		let [icon, iconHL] = TablineIcon(i + 1)

		" Select the highlighting of the sign
		if i + 1 == tabpagenr()
			let s .= '%#BufferCurrentSign#'
		else
			let s .= '%#BufferInactiveSign#'
			let iconHL = 'BufferInactive'
		endif
		let s .= '▎'

		" Show file icon with color if active
		let s .= '%#' . iconHL . '#' . icon . ' '
		if i + 1 == tabpagenr()
			let s .= '%#BufferCurrent#'
		else
			let s .= '%#BufferInactive#'
		endif

		" Set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'

		" Show name and if the file is modified
		let s .= '%{TablineName(' . (i + 1) . ')}'
		let s .= '%{TablineModified(' . (i + 1) . ')} '
	endfor

	" After the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'

	" Right align for coc-status
	let s .= '%='
	if 1
		let s .= TablineCocStatus()
	end

	return s
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

function! TablineRainbowColor(n)
	let rainbowcolors = ["Html", "Rss", "Js", "Vim", "Lua", "Jl"]
	return rainbowcolors[a:n % 6] . "DevIcon"
endfunc

function! TablineIcon(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let l:name = bufname(l:bufnr)
	let basename = fnamemodify(l:name, ':t')
	let extension = matchstr(basename, '\v\.@<=\w+$', '', '')
	let [icon, hl] = luaeval("get_icon_wrapper(_A)", [basename, extension])
	if icon == '' || icon == ''
		let icon = ""
		let hl = TablineRainbowColor(a:n - 1)
	end
	if l:name =~ '[0-9]*;#FZF'
		let icon = ''
		let hl = TablineRainbowColor(str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]) % 6)
	elseif l:name =~ 'help\.txt'
		let icon = 'ﬤ'
	end
	return [icon, hl]
endfunc

function! TablineName(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let l:name = bufname(l:bufnr)
	if empty(l:name)
		return '[No Name]'
	end
	if l:name =~ '[0-9]*;#FZF'
		return '[FZF] '
	end
	return fnamemodify(l:name, ':t')
endfunction

function! TablineModified(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	let l:filetype = getbufvar(l:bufnr, '&ft')
	let l:modified = getbufvar(l:bufnr, '&modified')
	let l:modifiable = getbufvar(l:bufnr, '&modifiable')
	return l:filetype ==# 'help' ? '' : l:modified ? '  ' : l:modifiable ? '' : ' '
endfunction

function! TablineCocStatus()
	let status = get(b:, 'coc_diagnostic_info', {})
	let textStart = '%#TablineSeparator#'
	" let textEnd = ' %#TablineSeparator#'
	let textEnd = ' '
	let c = textStart
	if empty(status) | return '' | endif
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
	" return c . ' '
	return c . textEnd
endfunc

