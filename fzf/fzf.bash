# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/cooperanderson/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/cooperanderson/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/cooperanderson/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/cooperanderson/.fzf/shell/key-bindings.bash"

