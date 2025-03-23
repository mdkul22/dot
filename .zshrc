# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="candy"

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
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

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
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias vi='nvim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/Users/mdk/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/Users/mdk/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/Users/mdk/opt/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/Users/mdk/opt/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<
export PATH="$HOME/.pyenv/bin:$PATH"

# Initialize pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi
export PATH="/opt/homebrew/bin:$PATH"
alias gc='git checkout'
alias gf='git fetch'
alias gp='git pull'
alias ls='eza'
alias zshrc='source ~/.zshrc'
alias vizshrc='vi ~/.zshrc'
export ZK_NOTEBOOK_DIR="/Users/mdk/notes"

cdd() {
  local input=$1
  local day time full_day formatted_date

  # Extract the day and time from the input (e.g., nwedT1400 -> nwed, 1400)
  day="${input%%T*}"
  time="${input#*T}"

  # Map your custom shorthand days to "next <day>"
  case "$day" in
    mon) full_day="next mon" ;;
    tue) full_day="next tue" ;;
    wed) full_day="next wed" ;;
    thu) full_day="next thu" ;;
    fri) full_day="next fri" ;;
    sat) full_day="next sat" ;;
    sun) full_day="next sun" ;;
    nmon) full_day="mon next week" ;;
    ntue) full_day="tue next week" ;;
    nwed) full_day="wed next week" ;;
    nthu) full_day="thu next week" ;;
    nfri) full_day="fri next week" ;;
    nsat) full_day="sat next week" ;;
    nsun) full_day="sun next week" ;;
    *) echo "Invalid day format"; return 1 ;;
  esac

  # Convert the date to Taskwarrior's format (YYYY-MM-DD)
  formatted_date=$(gdate -d "$full_day" "+%Y-%m-%d")T"${time:0:2}:${time:2:2}:00"

  # Output the full date-time string
  echo "$formatted_date"
}


function gtn() {
    local try=$1
    local option=$2

    if [[ "$try" == "--help" || "$try" == "-h" ]]; then
        echo "  Usage: gtn <task id/uuid> [-nl|-h|--help]"
        echo "    gtn <task-id/uuid> [options]"
        echo "    Options:"
        echo "      <task id / uuid> Taskwarrior id and uuid"
        echo "      -nl/--new-link  create new note when you have a prexisting note and link to task"
        echo "      -h/--help print help string"
        echo "    Notes:" 
        echo "      Use gtn to create zk notes from your tasks"
        echo "      gtn also auto-starts and stops your task based on when you enter and exit neovim."
    fi
    
    local task_id=$try
    if [ -z "$task_id" ]; then
        echo "No task selected."
        return
    fi
    
    note_path=$(task _get $task_id.zt_note)

    if [[ "$option" == "-nl" ]]; then
        echo "Creating new note link..."
        echo "Input filename:"
        read filename
        new_note_path=$(zk new --title "$filename" --print-path)

        if [ -z "$note_path" ]; then
            note_path="$new_note_path"
        else
            note_path="$note_path $new_note_path"
        fi

        task $task_id mod zt_note:"$note_path"
        echo "New note linked and added to task $task_id."
    fi
    
    if [ -z "$note_path" ]; then
        echo "No linked note for task $task_id."
        echo "creating new note..."
        echo "Input filename:"
        read filename
        note_path=`zk new --title $filename --print-path`
        task $1 mod zt_note:"$note_path"
    fi

    task start $task_id
    trap "echo 'Neovim exited. Stopping task...'; task $task_id stop" EXIT

    vi "$note_path"
}
