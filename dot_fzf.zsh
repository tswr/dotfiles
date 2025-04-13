# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tswr/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tswr/.fzf/bin"
fi

export FZF_CTRL_R_OPTS='--layout=reverse'

source <(fzf --zsh)
