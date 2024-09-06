# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gcloud)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function prompt_metalctl() {
  local ctx=$(metalctl context short)
  local u=$(metalctl context |grep "*"|cut -d" " -f5)
  p10k segment -f blue -t "${ctx} (${u// /})"
}

function prompt_cloudctl() {
  local ctx=$(cloudctl context short)
  local u=$(cloudctl context |grep "*"|cut -f2)
  p10k segment -f blue -t "${ctx} (${u// /})"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_METALCTL_SHOW_ON_COMMAND='metalctl|m'
typeset -g POWERLEVEL9K_CLOUDCTL_SHOW_ON_COMMAND='cloudctl|c'

autoload -U compinit; compinit

mct() {
  export KUBECONFIG=~/.cloudctl/test_kubeconfig.yaml
  metalctl context dev
  cloudctl context dev
  gcloud config configurations activate test
}

mci() {
  export KUBECONFIG=~/.cloudctl/int_kubeconfig.yaml
  metalctl context int
  cloudctl context int
  gcloud config configurations activate int
}

mcp() {
  export KUBECONFIG=~/.cloudctl/prod_kubeconfig.yaml
  metalctl context prod
  cloudctl context prod
  gcloud config configurations activate prod
}

mcloud() {
  export KUBECONFIG=~/.metalctl/mcloud_kubeconfig.yaml
  metalctl context mcloud
  gcloud config configurations activate mcloud
}

kc() {
  export KUBECONFIG=$(readlink -f "$1")
}

alias vi=vim
alias watch='watch -c '
alias k='kubectl'
alias m='metalctl'
alias c='cloudctl'
alias ansible-common-venv='. /home/gerrit/git/github.com/metal-stack/ansible-common/venv/bin/activate'
alias dotfiles='/usr/bin/git --git-dir="$HOME/git/github.com/Gerrit91/dotfiles/" --work-tree="$HOME"'
alias ssh="kitten ssh"
alias mc=mcli

# source <(stern --completion=zsh)
source <(kubectl completion zsh)
source /usr/share/nvm/init-nvm.sh

echo -e '#compdef _cloudctl cloudctl\n. <(cloudctl completion zsh)' > ${fpath[1]}/_cloudctl
echo -e '#compdef _metalctl metalctl\n. <(metalctl completion zsh)' > ${fpath[1]}/_metalctl
echo -e '#compdef _metal metal\n. <(metal completion zsh)' > ${fpath[1]}/_metal

complete -F __start_kubectl k
complete -F __start_metalctl m
complete -F __start_cloudctl c
complete -F _complete_alias dotfiles
# complete -C /usr/local/bin/mc mc

export CLOUDSDK_ROOT_DIR=/opt/google-cloud-cli
export CLOUDSDK_PYTHON=/usr/bin/python
export CLOUDSDK_PYTHON_ARGS='-S -W ignore'
export PATH=$CLOUDSDK_ROOT_DIR/bin:$PATH
export GOOGLE_CLOUD_SDK_HOME=$CLOUDSDK_ROOT_D

export CLOUDCTL_FORCE_COLOR=true
export METALCTL_FORCE_COLOR=true

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export EDITOR=vim
