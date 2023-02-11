# Zgen, need to 'zgen reset' after changing
source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
	zgen oh-my-zsh
	zgen oh-my-zsh plugins/command-not-found
	zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/wd
    zgen oh-my-zsh plugins/gitfast
    zgen load https://github.com/zsh-users/zsh-syntax-highlighting
	zgen load https://github.com/paulirish/git-open
    zgen save
fi

# Vim mode
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# autocompletions
fpath=(~/.completions $fpath)

# Enable alias autocompletion
compdef woman=man
compdef vi=nvim
compdef vim=nvim
compdef nvi=nvim
compdef dotf=git

# compsys initialization
autoload -U compinit
compinit

# Zsh prompt
PROMPT='%B%F{blue}%n%F{blue}@%F{blue}%m%f%b in %B%F{green}%~%f%b$(git_prompt_info)
%(?:$ :%F{red}$ )%f'

ZSH_THEME_GIT_PROMPT_PREFIX=' on %B%F{magenta}'
ZSH_THEME_GIT_PROMPT_SUFFIX='%f%b'
ZSH_THEME_GIT_PROMPT_DIRTY='%F{yellow}*'
ZSH_THEME_GIT_PROMPT_UNTRACKED='%F{yellow}*'
ZSH_THEME_GIT_PROMPT_CLEAN=''

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

checkMakefileNear() {
    cwd=`pwd`

    for i in {1..3}
    do
        if [ ! -f "makefile" ]; then
            cd ..
        else
            cd $cwd
            return 0
        fi
    done

    cd $cwd
    return 1
}

command_not_found_handler() {
  local pkgs cmd="$1"

  if checkMakefileNear; then
    run "$@"
    return 0
  fi

  pkgs=(${(f)"$(pkgfile -b -v -- "$cmd" 2>/dev/null)"})
  if [[ -n "$pkgs" ]]; then
    printf '%s may be found in the following packages:\n' "$cmd"
    printf '  %s\n' $pkgs[@]
    return 0
  fi

  printf 'zsh: command not found: %s\n' "$cmd" 1>&2
  return 127
}

new_project_from() {
    git clone -b $1 git@bitbucket.org:jendrusha/docker.git $2
    cd $2
    git co -b $2
}

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias luamake=/home/domin/tmp/1/lua-language-server/3rd/luamake/luamake
