# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.local/share/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
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
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

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
plugins=(git rails aws terraform tmuxinator docker-compose)

source $ZSH/oh-my-zsh.sh

# Disable history sharing
unsetopt share_history

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Disable less history
export LESSHISTFILE=-

# Change AWS CLI configuration location
export AWS_CONFIG_FILE="$HOME/.config/aws/config"

# Increase default Terraform parallelism
export TFE_PARALLELISM=30

# Shut Lefthook up as much as possible
export LEFTHOOK_QUIET="meta,summary,execution,execution_info,skips"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias config='git --git-dir=$HOME/.config/.git --work-tree=$HOME/.config'
alias vim='nvim'

alias mux='tmuxinator'
alias tks='tmux kill-server'
alias tkd='tmux list-session | grep -v " (attached)$" | cut -d: -f1 | xargs -r -L1 tmux kill-session -t' # Kill all detached sessions
alias tls='tmux list-session'
alias bex='mux bex'
alias cms='mux cms'
alias apps='mux apps'
alias gems='mux gems'
alias sema='mux sema'
alias terra='mux terra'
alias pb='mux pb'
alias ocd='mux ocd'
alias cmn='mux cmn'
alias cli='mux cli'
alias mono='mux mono'
alias ds='mux ds'
alias svcs='mux svcs'

alias rb='bundle exec rubocop'
alias rba='rb -a'
alias rbA='rb -A'

alias gcw='gc -n -m "WIP" -m "[skip ci]"'

alias tws='terraform workspace'

# CUSTOM FUNCTIONS

# SSM
ssm () {
  aws ssm start-session --target $1 --document-name SSM-StartInteractiveCommand --parameters command='["/bin/bash -l"]'
}

ssm-session-log () {
  echo -e $(aws logs get-log-events --log-group-name=/aws/ssm/session-logs --log-stream-name=$1 | jq ".events[0].message")
}

# Terraform
terraform-targets () {
  sed 's/\x1b\[[0-9;]*m//g' | grep -o '# [^( ]* ' | grep '\.' | sed " s/^# /-target '/; s/ $/'/; "
}

terraform-grep () {
  terraform plan | terraform-targets | grep $1
}

terraform-grep-apply () {
  terraform-grep $1 | xargs -r -o terraform apply
}

terraform-lock () {
  terraform providers lock -platform=darwin_amd64 -platform=linux_amd64
}

terraform-diff-update () {
  terraform plan -target="$1" -out=tfplan && diff <(terraform show -json tfplan | jq -r '.resource_changes[] | select(.change.actions | index("update")) | .change.before') <(terraform show -json tfplan | jq -r '.resource_changes[] | select(.change.actions | index("update")) | .change.after')
}

terraform-diff-replace () {
  terraform plan -target="$1" -out=tfplan && diff <(terraform show -json tfplan | jq -r '.resource_changes[] | select(.change.actions == ["delete", "create"]) | .change.before') <(terraform show -json tfplan | jq -r '.resource_changes[] | select(.change.actions == ["delete", "create"]) | .change.after')
}

# Docker
docker-login () {
  aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 762732311162.dkr.ecr.eu-central-1.amazonaws.com
}

# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

eval "$(rbenv init - zsh)"
eval "$(direnv hook zsh)"
