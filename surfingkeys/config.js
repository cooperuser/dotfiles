for (const letter of "bwegh") removeSearchAliasX(letter, 's');

settings.scrollStepSize = 100;
settings.modeAfterYank = "Normal";
settings.defaultSearchEngine = 'd';
settings.hintAlign = "left";
settings.omnibarSuggestion = true;
settings.focusFirstCandidate = false;
settings.startToShowEmoji = false;
Hints.scrollKeys = "0jkhlG$<Ctrl-d><Ctrl-e>";
Hints.characters = "asdfwertzxc";
// Hints.characters = "asdfgwertzxcv";

// map('F', 'af');
let lastColor = 0;
mapkey('f', '#1Open a link', () => {
	setStyle(s.colors.blue);
	Hints.create("", Hints.dispatchMouseClick);
});

unmap('0');
unmap('af');
unmap('ab');
iunmap(":");

mapkey('F', '#1Open a link in new tab', () => {
	setStyle(s.colors.green);
	Hints.create("", Hints.dispatchMouseClick, {tabbed: true});
});

mapkey('aa', '#1Open multiple links in a new tab', function() {
	setStyle(s.colors.red);
	Hints.create("", Hints.dispatchMouseClick, {multipleHits: true});
});

mapkey('ax', '#1Open link in a new incognito window', function() {
	setStyle(s.colors.purple);
	Hints.create('*[href]', function(element) {
		RUNTIME('openIncognito', {
			url: element.href
		});
	});
});

mapkey('aw', '#1Open link in a new window', function() {
	setStyle(s.colors.grey);
	Hints.create('*[href]', function(element) {
		open(element.href, "_blank");
	});
});

mapkey('af', '#1Open a link in non-active new tab', function() {
	setStyle(s.colors.yellow);
	Hints.create("", Hints.dispatchMouseClick, {tabbed: true, active: false});
});

mapkey('o', '#8Open a URL', () => {
	Front.openOmnibar({type: "URLs", extra: "getAllSites", tabbed: false});
});

mapkey('O', '#8Open a URL in a new tab', () => {
	Front.openOmnibar({type: "URLs", extra: "getAllSites"});
});

mapkey('t', '#3Open newtab', () => {
	tabOpenLink("https://duckduckgo.com/");
});

mapkey('H', '#4Go back in history', () => {
	history.go(-1);
}, {repeatIgnore: true});
mapkey('L', '#4Go forward in history', () => {
	history.go(1);
}, {repeatIgnore: true});

mapkey('ye', '#7Yank text of an element', function() {
	Visual.toggle("y");
});

mapkey('yr', "#7Yank repository path of url", () => {
	const url = window.location.href;
	const match = "https://github.com/";
	if (!url.startsWith(match)) return;
	Clipboard.write(url.substr(match.length));
});

mapkey('p', "Open the clipboard's URL in the current tab", function() {
	Clipboard.read(function(response) {
		window.location.href = response.data;
	});
});

mapkey(',', '#0enter PassThrough mode to temporarily suppress SurfingKeys', function() {
	Normal.passThrough(1000);
});

mapkey('e', '#9Backward half page', function() { Normal.feedkeys('2k'); });
mapkey('d', '#9Forward half page', function() { Normal.feedkeys('2j'); });
mapkey('<Ctrl-e>', '#9Backward half page', function() { Normal.feedkeys('2k'); });
mapkey('<Ctrl-d>', '#9Forward half page', function() { Normal.feedkeys('2j'); });
// map('<Ctrl-d>', 'd');
// map('<Ctrl-e>', 'e');
map('u', 'e');

map('<Ctrl-j>', 'E');
map('<Ctrl-k>', 'R');
cmap('<Ctrl-n>', '<Tab>');
cmap('<Ctrl-j>', '<Tab>');
cmap('<Ctrl-p>', '<Shift-Tab>');
cmap('<Ctrl-k>', '<Shift-Tab>');
map('>', '>>');
map('<', '<<');

mapkey('J', '#4Go one tab history back', function() {
	RUNTIME("historyTab", {backward: true});
}, {repeatIgnore: true});
mapkey('K', '#4Go one tab history forward', function() {
	RUNTIME("historyTab", {backward: false});
}, {repeatIgnore: true});

mapkey('<Alt-r><Alt-r>', "Read with Readio", function() {
	document.getElementById("sr-qa-trigger-read").click();
})

mapkey('<Alt-r><Alt-e>', "Open Readio editor", function() {
	document.getElementById("sr-qa-trigger-edit").click();
})

// Unmap {{{
// Proxy Stuff
unmap('spa');
unmap('spb');
unmap('spc');
unmap('spd');
unmap('sps');
unmap('cp');
unmap(';cp');
unmap(';ap');

// Misc
unmap(';t');
unmap('si');
unmap('ga');
unmap('gc');
unmap('gn');
unmap('gr');
unmap('ob');
unmap('og');
unmap('od');
unmap('oy');
// }}}

// mapkey('<Space>f', 'Choose a tab with omnibar', function() {
// 	Front.openOmnibar({type: "Tabs"});
// });

// mapkey('<Space>F', "Choose a tab through the selector", () => {
// 	Front.chooseTab();
// });

mapkey('<Shift-Space>', "Choose a tab through the selector", () => {
	RUNTIME("goToLastTab");
});

// Search Aliases {{{
addSearchAlias('d', 'ddg', 'https://duckduckgo.com/?q=',
	'https://duckduckgo.com/ac/?q=', response => {
		var res = JSON.parse(response.text);
		return res.map(r => r.phrase);
	}
);

addSearchAliasX('g', 'github', 'https://github.com/search?q=', 's',
	'https://api.github.com/search/repositories?order=desc&q=', response => {
		var res = JSON.parse(response.text)['items'];
		return res ? res.map(r => {
			return { title: r.description, url: r.html_url }
		}) : [];
	}
);

addSearchAliasX('r', 'repo', 'https://github.com/search?q=', 's',
	'https://api.github.com/search/repositories?q=%20+fork:true+user:cooper-anderson+', response => {
		var res = JSON.parse(response.text)['items'];
		return res ? res.map(r => {
			return { title: r.description, url: r.html_url }
		}) : [];
	}
);

addSearchAliasX('t', 'the-digital', 'https://github.com/search?q=org:the-digital+', 's',
	'https://api.github.com/search/repositories?q=org:the-digital+', response => {
		var res = JSON.parse(response.text)['items'];
		return res ? res.map(r => {
			return { title: r.description, url: r.html_url }
		}) : [];
	}
);

addSearchAliasX('w', 'wikipedia', 'https://en.wikipedia.org/wiki/', 's',
	'https://en.wikipedia.org/w/api.php?action=opensearch&format=json&formatversion=2&namespace=0&limit=40&search=', response => {
		return JSON.parse(response.text)[1];
	}
);
// }}}

const s = {
	colors: {
		blue: "#51afef",
		green: "#98be65",
		red: "#ff6c6b",
		yellow: "#f2c68a",
		purple: "#c678dd",
		grey: "#a0a0a0",
	},
	shadow: `0 2px 4px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24)`,
	minWidth: "12px",
	minHeight: "14px",
	font: {
		family: `"Helvetica Neue", "Helvetica", "Arial", sans-serif`,
		size: "13px",
		weight: "bold",
	}
}

Visual.style('marks', `
	animation: sk-breathe 500ms linear alternate infinite;
	background-color: #C5B807a0;
`);
Visual.style('cursor', `
	transform: translateX(-50%) scale(1.25);
	border-radius: 3px;
	background-color: ${s.colors.purple};
	animation: sk-breathe 500ms linear alternate infinite;
	z-index: 2147483298;
`);

const color = document.createElement("style");
color.innerHTML = `
	:root {
		--sk-color: ${s.colors.blue};
	}
`;
document.head.appendChild(color);

let style = `
	@keyframes sk-breathe {
		0% { opacity: 0.8; }
		100% { opacity: 0.35; }
	}
	@keyframes sk-fade-in {
		0% {
			opacity: 0.0;
			transform: scale(0) translateY(-15px);
		}
		25% { opacity: 1.0; }
		80% { transform: scale(1) }
		90% { transform: scale(1.125); }
		100% { transform: scale(1) translateY(0px);; }
	}

	[mode="text"] div {
		color: #424242e0 !important;
		background-color: ${s.colors.grey} !important;
		border: 1px solid ${s.colors.grey} !important;
	}

	[mode="text"] div.begin {
		color: #424242e0 !important;
		background-color: ${s.colors.blue} !important;
		border: 1px solid ${s.colors.blue} !important;
	}

	div {
		position: fixed;
		background: initial !important;
		background-color: var(--sk-color) !important;
		border: 1px solid var(--sk-color);
		border-radius: 25px;
		box-shadow: ${s.shadow};
		padding: 2px 3px 2px;
		min-width: ${s.minWidth};
		min-height: ${s.minHeight};
		color: #424242e0;
		opacity: 1.0;
		font-family: ${s.font.family};
		font-size: ${s.font.size};
		font-weight: ${s.font.weight};
		line-height: ${s.minHeight};
		text-align: center;
		animation: sk-fade-in 300ms;
		animation-timing-function: ease-out;
		transition: opacity 300ms;
	}
`;
function loopStyle() {
	let element = document.querySelector("div").shadowRoot.firstElementChild;
	if (!element) requestAnimationFrame(loopStyle);
	else {
		element.innerHTML = style;
	}
}
loopStyle();

function setStyle(c) {
	color.innerHTML = `:root {--sk-color: ${c};}`;
}

settings.theme = `
	@keyframes sk-rise {
		0% {
			opacity: 0.0;
			transform: translateY(15px);
		}
		100% {
			opacity: 1.0;
			transform: translateY(0px);
		}
	}
	@keyframes sk-enter {
		0% {
			opacity: 0.0;
			filter: blur(2px);
		}
		100% {
			opacity: 1.0;
			filter: blur(0px);
		}
	}

	:root {
		--font: Arial;
		--font-mono: 'Iosevka Copper', Ubuntu, sans;
		--font-size: 18;
		--font-weight: regular;
		
		--theme-ace-bg:#282828ab; /*Note the fourth channel, this adds transparency*/
		--theme-ace-bg-accent:#3c3836;
		--theme-ace-fg:#ebdbb2;
		--theme-ace-fg-accent:#7c6f64;
		--theme-ace-cursor:#928374;
		--theme-ace-select:#458588;

		--fg: #C5C8C6;
		--bg: #282A2Ed0;
		--bg-dark: #1D1F21d0;
		--border: #373b41d0;
		--main-fg: #81A2BE;
		--accent-fg: #52C196;
		--info-fg: #AC7BBA;
		--select: #585858;
	}

	.sk_theme {
		background: var(--bg);
		color: var(--fg);
		background-color: var(--bg);
		border-color: var(--border);
		font-family: var(--font);
		font-size: var(--font-size);
		font-weight: var(--font-weight);
	}
	input {
		font-family: var(--font);
		font-weight: var(--font-weight);
	}
	.sk_theme tbody {
		color: var(--fg);
	}
	.sk_theme input {
		color: var(--fg);
	}

	#sk_tabs .sk_tab {
		animation: sk-enter;
		width: 189px !important;
		background: var(--bg-dark);
		border: 1px solid var(--border);
	}
	#sk_tabs .sk_tab:nth-child(1) { animation-duration: 300ms; }
	#sk_tabs .sk_tab:nth-child(2) { animation-duration: 400ms; }
	#sk_tabs .sk_tab:nth-child(3) { animation-duration: 500ms; }
	#sk_tabs .sk_tab:nth-child(4) { animation-duration: 600ms; }
	#sk_tabs .sk_tab:nth-child(5) { animation-duration: 700ms; }
	#sk_tabs .sk_tab:nth-child(6) { animation-duration: 800ms; }
	#sk_tabs .sk_tab:nth-child(7) { animation-duration: 900ms; }


	#sk_tabs .sk_tab_title {
		color: var(--fg);
	}
	#sk_tabs .sk_tab_url {
		color: var(--main-fg);
	}
	#sk_tabs .sk_tab_hint {
		text-transform: lowercase;
		background: var(--bg);
		border: 1px solid var(--border);
		color: var(--accent-fg);
	}
	.sk_theme #sk_frame {
		background: var(--bg);
		opacity: 0.2;
		color: var(--accent-fg);
	}

	.sk_theme .title {
		color: var(--accent-fg);
	}
	.sk_theme .url {
		color: var(--main-fg);
	}
	.sk_theme .annotation {
		color: var(--accent-fg);
	}
	.sk_theme .omnibar_highlight {
		text-decoration: underline;
		color: var(--accent-fg);
	}
	.sk_theme .omnibar_timestamp {
		color: var(--info-fg);
	}
	.sk_theme .omnibar_visitcount {
		color: var(--accent-fg);
	}
	#sk_omnibar {
		animation: sk-rise 500ms;
	}
	.sk_theme #sk_omnibarSearchResult {
		animation: sk-enter 500ms;
	}
	.sk_theme #sk_omnibarSearchResult ul li {
		padding: 8px;
		border-radius: 5px;
	}
	.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
		background: var(--bg-dark);
	}
	.sk_theme #sk_omnibarSearchResult ul li.focused {
		background: var(--border);
	}
	.sk_theme #sk_omnibarSearchArea {
		border-top-color: var(--border);
		border-bottom-color: var(--border);
	}
	.sk_theme #sk_omnibarSearchArea input,
	.sk_theme #sk_omnibarSearchArea span {
		font-size: var(--font-size);
	}
	.sk_theme .separator {
		color: var(--accent-fg);
	}

	#sk_banner {
		font-family: var(--font);
		font-size: var(--font-size);
		font-weight: var(--font-weight);
		background: var(--bg);
		border-color: var(--border);
		color: var(--fg);
		opacity: 0.9;
	}

	#sk_keystroke {
		animation: sk-rise 500ms;
		font-family: var(--font-mono) !important;
		font-size: var(--font-size);
		margin-bottom: 16px;
		margin-right: 16px;
		background-color: var(--bg);
		border-radius: 8px;
	}
	#sk_keystroke div {
		animation: sk-enter 500ms;
	}
	#sk_keystroke div:nth-child(odd) {
		border-radius: 5px;
		background: var(--bg-dark);
	}
	.sk_theme kbd .candidates {
		color: var(--info-fg);
	}
	.sk_theme span.annotation {
		color: ${s.colors.grey};
	}

	#sk_bubble {
		background-color: var(--bg) !important;
		color: var(--fg) !important;
		border-color: var(--border) !important;
	}
	#sk_bubble * {
		color: var(--fg) !important;
	}
	#sk_bubble div.sk_arrow div:nth-of-type(1) {
		border-top-color: var(--border) !important;
		border-bottom-color: var(--border) !important;
	}
	#sk_bubble div.sk_arrow div:nth-of-type(2) {
		border-top-color: var(--bg) !important;
		border-bottom-color: var(--bg) !important;
	}

	#sk_status {
		animation: sk-rise 500ms;
		font-family: var(--font-mono) !important;
		font-size: var(--font-size);
		border-color: var(--border);
		padding: 8px;
		border-radius: 32px;
		margin-bottom: 16px;
	}
	#sk_status span:nth-child(1) {
		color: ${s.colors.yellow};
		padding: 0 16px 0 14px !important;
	}
	#sk_find {
		background-color: #00000000;
		font-family: var(--font-mono) !important;
	}
	.sk_theme kbd {
		background: var(--bg-dark);
		border-color: var(--border);
		box-shadow: none;
		color: var(--fg);
		margin-right: 6px;
		margin-bottom: 2.8px;
		transform: scale(1.4);
	}
	.sk_theme .feature_name span {
		color: var(--main-fg);
	}


	#sk_editor {
		background: var(--bg-dark) !important;
		height: 50% !important;
	}
	.ace_dialog-bottom {
		border-top: 1px solid var(--bg) !important;
	}
	.ace-chrome .ace_print-margin, .ace_gutter, .ace_gutter-cell, .ace_dialog {
		background: var(--bg) !important;
	}
	.ace-chrome {
		color: var(--fg) !important;
	}
	.ace_gutter, .ace_dialog {
		color: var(--fg) !important;
	}
	.ace_cursor {
		color: var(--fg) !important;
	}
	.normal-mode .ace_cursor {
		background-color: var(--fg) !important;
		border: var(--fg) !important;
		opacity: 0.7 !important;
	}
	.ace_marker-layer .ace_selection {
		background: var(--select) !important;
	}
	.ace_editor, .ace_dialog span, .ace_dialog input {
		font-family: var(--font-mono);
		font-size: var(--font-size);
		font-weight: var(--font-weight);
	}

`;

const API_KEY = '387833b7-267d-4836-ac8e-e95def67fce1';
const API_URL = 'https://dictionaryapi.com/api/v3';

Front.registerInlineQuery({
	url: function(q) {
		const url = `${API_URL}/references/learners/json/${q}?key=${API_KEY}`;
		return url;
	},
	parseResult: function(res) {
		try {
			const [firstResult] = JSON.parse(res.text);
			if (firstResult) {
				let definitionsList = `<ul><li>No definitions found</li></ul>`;
				let pronunciationsList = `<ul><li>No pronunciations found</li></ul>`;
				if (firstResult.hasOwnProperty('shortdef')) {
					const definitions = [];
					for (let definition of firstResult.shortdef) {
						definitions.push(`${definition}`);
					}
					const definitionListItems = definitions.map(function(definition) {
						return `<li>${definition}</li>`;
					});
					definitionsList = `<ul>${definitionListItems.join('')}</ul>`;
					//TODO: Separate this function if possible
				}
				if (firstResult.hasOwnProperty('hwi')) {
					const pronunciations = [];
					const resultPronunciationsArray = firstResult.hwi.prs;
					if (resultPronunciationsArray && resultPronunciationsArray.length !== 0) {
						for (let i=0; i < resultPronunciationsArray.length; i++) {
							if (resultPronunciationsArray[i].l) {
								pronunciations.push(`<li>${resultPronunciationsArray[i].l} -- ${resultPronunciationsArray[i].ipa}</li>`);
							} else {
								pronunciations.push(`<li>${resultPronunciationsArray[i].ipa}</li>`);
							}
						}

						pronunciationsList = `<ul>${pronunciations.join('')}</ul>`;
					}
				}
				return `
					<h3>Pronunciations</h3>
					${pronunciationsList}<hr/>
					<h3>Definitions</h3>
					${definitionsList}
				`;
			} else {
				return `<h3>This is not the definition you were looking for...</h3>`;
			}
		} catch (e) {
			console.log(e.message);
			return 'Something bad happend... Look behind you, a three headed monkey!';
		}
	}
});
