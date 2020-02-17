PROMPT=$'%{$fg_bold[red]%}┌[%{$fg_bold[brown]%}%n%{$reset_color%}%{$fg_bold[yellow]%}@%{$fg_bold[blue]%}%m%{$reset_color%}%{$fg_bold[red]%}][%{$fg_bold[green]%}%~%{$reset_color%}%{$fg_bold[red]%}]> %{$(git_prompt_info)%}%(?,,%{$fg_bold[red]%}[%{$fg_bold[white]%}%?%{$reset_color%}%{$fg_bold[red]%}])
%{$fg_bold[red]%}└──╼%{$fg_bold[yellow]%}$%{$reset_color%} '
PS2=$' %{$fg_bold[green]%}|>%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[red]%}[%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[red]%}] "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}⚡%{$reset_color%}"

