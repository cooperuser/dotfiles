from ptpython.layout import CompletionVisualisation

def configure(repl):
	repl.show_docstring = True
	repl.show_meta_enter_message = False
	repl.completion_visualisation = CompletionVisualisation.POP_UP
	repl.show_line_numbers = True
	repl.vi_mode = True
	repl.insert_blank_line_after_output = False
	repl.confirm_exit = False
	repl.use_code_colorscheme("monokai")
	repl.true_color = True

