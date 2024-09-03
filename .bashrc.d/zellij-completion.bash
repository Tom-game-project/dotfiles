_dummy()
{
  # zellij-completion-helper.py
  local cur prev cword
  _get_comp_words_by_ref -n : cur prev cword
  complist=$(zellij ls -n | awk '{print $1}')
  #   echo \"$cur\" \"$prev\" \"$cword\"
  COMPREPLY=$(python3 ~/.bashrc.d/zellij-completion-helper.py --cur ${cur} --prev ${prev} --cword ${cword} --candidate ${complist})
}

complete -F _dummy zellij