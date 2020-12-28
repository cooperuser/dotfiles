set tabline=%!MyTabLine()  " custom buffer line

function MyTabLine()
	let s = ''
	for i in range(bufnr('$'))
		let l:name = bufname(i + 1)
		let visible = buf#activity(i + 1)

		if !buflisted(i + 1) " || empty(l:name)
			continue
		end
		let [icon, iconHL] = TablineIcon(i + 1)

		" Select the highlighting of the sign
		if i + 1 == bufnr()
			let s .= '%#BufferCurrentSign#'
		elseif visible == 1
			let s .= '%#BufferVisibleSign#'
		else
			let s .= '%#BufferInactiveSign#'
			let iconHL = 'BufferInactive'
		endif
		let s .= '▎'

		" Show file icon with color if active
		let s .= '%#' . iconHL . '#' . icon . ' '
		if i + 1 == bufnr()
			let s .= '%#BufferCurrent#'
		elseif visible == 1
			let s .= '%#BufferVisible#'
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
	return "DevIcon" . rainbowcolors[a:n % 6]
endfunc

function! TablineIcon(n)
	let l:name = bufname(a:n)
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
	let l:name = bufname(a:n)
	if empty(l:name)
		return '[No Name]'
	end
	if l:name =~ '[0-9]*;#FZF'
		return '[FZF] '
	end
	return fnamemodify(l:name, ':t')
endfunction

function! TablineModified(n)
	let l:bufnr = a:n
	if &buftype == 'terminal'
		return ''
	end
	let l:filetype = getbufvar(l:bufnr, '&ft')
	let l:modified = getbufvar(l:bufnr, '&modified')
	let l:modifiable = getbufvar(l:bufnr, '&modifiable')
	return l:filetype ==# 'help' ? '' : l:modified ? '  ' : l:modifiable ? '' : ' '
endfunction

function! TablineCocStatus()
	let l:numbers = luaeval("GetStatusNumbers()")
	let l:errors = l:numbers[0]
	let l:warnings = l:numbers[1]
	let l:infos = l:numbers[2]
	let l:hints = l:numbers[3]
	let textStart = '%#TablineSeparator#'
	let textEnd = ' '
	let c = textStart
	if l:hints != 0
		let c .= '%#TablineHint# ﬤ ' . l:hints
	endif
	if l:infos != 0
		let c .= '%#TablineInfo#  ' . l:infos
	endif
	if l:warnings != 0
		let c .= '%#TablineWarning#  ' . l:warnings
	endif
	if l:errors != 0
		let c .= '%#TablineError#  ' . l:errors
	endif
	if l:errors + l:warnings + l:infos + l:hints == 0
		let c .= '%#TablineSuccess# '
	endif
	return c . textEnd
endfunc

