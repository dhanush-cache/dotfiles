# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

export ZELLIJ_AUTO_EXIT="true"
eval "$(zellij setup --generate-auto-start zsh)"

source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::python
# zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aliases
zinit snippet OMZP::pipenv 2> /dev/null
zinit snippet OMZP::pass/_pass 2> /dev/null
zinit snippet OMZP::command-not-found
zinit snippet OMZ::lib/directories.zsh
zinit snippet OMZ::lib/key-bindings.zsh

autoload -Uz compinit && compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'm:{A-Za-z}={a-zA-Z}'
eval $(dircolors -b)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' completion menu no 

alias ls="ls --color"

source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"


clear-screen() {
  local precmd
  for precmd in $precmd_functions; do
    $precmd
  done
  printf "\e[H\e[3J"
}
zle -N clear-screen clear-screen

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

zstyle ':fzf-tab:*' fzf-flags ${(z)FZF_DEFAULT_OPTS}
export EDITOR=nvim
export VISUAL=nvim

source ~/.profile
