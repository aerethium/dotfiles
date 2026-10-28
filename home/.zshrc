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

# Uncomment the following line to change the frequency the auto-updater is run (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to set how old an update must be before it's applied, manually or via the auto-updater (in days).
# zstyle ':omz:update' cooldown 10

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
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
#
## --- Load Arch System Plugins & Functions ---
fpath=(/usr/share/zsh/site-functions $fpath)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Syntax Highlighting MUST be loaded last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias tdp1="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=1000 --fast-limit=1000 --slow-limit=1000"
alias tdp2="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=2000 --fast-limit=2000 --slow-limit=2000"
alias tdp3="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=3000 --fast-limit=3000 --slow-limit=3000"
alias tdp4="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=4000 --fast-limit=4000 --slow-limit=4000"
alias tdp5="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=5000 --fast-limit=5000 --slow-limit=5000"
alias tdp6="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=6000 --fast-limit=6000 --slow-limit=6000"
alias tdp7="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=7000 --fast-limit=7000 --slow-limit=7000"
alias tdp8="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=8000 --fast-limit=8000 --slow-limit=8000"
alias tdpreset="sudo ryzenadj --stapm-limit=28000 --fast-limit=64000 --slow-limit=28000 && sudo systemctl start power-profiles-daemon"
alias tdp1="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=1000 --fast-limit=1000 --slow-limit=1000"
alias tdp2="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=2000 --fast-limit=2000 --slow-limit=2000"
alias tdp3="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=3000 --fast-limit=3000 --slow-limit=3000"
alias tdp4="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=4000 --fast-limit=4000 --slow-limit=4000"
alias tdp5="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=5000 --fast-limit=5000 --slow-limit=5000"
alias tdp6="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=6000 --fast-limit=6000 --slow-limit=6000"
alias tdp7="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=7000 --fast-limit=7000 --slow-limit=7000"
alias tdp8="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=8000 --fast-limit=8000 --slow-limit=8000"
alias tdpreset="sudo ryzenadj --stapm-limit=28000 --fast-limit=64000 --slow-limit=28000 && sudo systemctl start power-profiles-daemon"
alias ls="lsd"
eval "$(zoxide init --cmd cd zsh)"
alias tdp1="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=1000 --fast-limit=1000 --slow-limit=1000"
alias tdp2="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=2000 --fast-limit=2000 --slow-limit=2000"
alias tdp3="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=3000 --fast-limit=3000 --slow-limit=3000"
alias tdp4="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=4000 --fast-limit=4000 --slow-limit=4000"
alias tdp5="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=5000 --fast-limit=5000 --slow-limit=5000"
alias tdp6="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=6000 --fast-limit=6000 --slow-limit=6000"
alias tdp7="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=7000 --fast-limit=7000 --slow-limit=7000"
alias tdp8="sudo systemctl stop power-profiles-daemon && sudo ryzenadj --stapm-limit=8000 --fast-limit=8000 --slow-limit=8000"
alias tdpreset="sudo ryzenadj --stapm-limit=28000 --fast-limit=64000 --slow-limit=28000 && sudo systemctl start power-profiles-daemon"
alias ls="lsd"
eval "$(zoxide init --cmd cd zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Monochrome zsh-syntax-highlighting styles
ZSH_HIGHLIGHT_STYLES[command]='fg=255,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=255,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=255,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=255,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=245,underline'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=248'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=248'
ZSH_HIGHLIGHT_STYLES[default]='fg=255'

# Force all syntax highlighting styles to monochrome (grayscale/white)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='fg=252'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=240,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=252'
ZSH_HIGHLIGHT_STYLES[alias]='fg=252'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=252'
ZSH_HIGHLIGHT_STYLES[function]='fg=252'
ZSH_HIGHLIGHT_STYLES[command]='fg=252'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=252'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=245'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=252'
ZSH_HIGHLIGHT_STYLES[path]='fg=248'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=248'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=248'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=245'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=245'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=245'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=245'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=245'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=242'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=242'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=242'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=242'
ZSH_HIGHLIGHT_STYLES[dollar-parameter]='fg=250'
ZSH_HIGHLIGHT_STYLES[variable]='fg=250'
ZSH_HIGHLIGHT_STYLES[assign]='fg=250'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=245'
ZSH_HIGHLIGHT_STYLES[comment]='fg=238,italic'

# Force lsd / ls directory and file colors to monochrome grays/whites
export LS_COLORS="di=01;37:ln=01;36:so=01;35:pi=01;33:ex=01;32:bd=01;33:cd=01;33:su=01;37:sg=01;37:tw=01;30;47:ow=01;30;47:"

# Force fzf and zoxide interactive menus to monochrome grays/whites
export FZF_DEFAULT_OPTS="--color=fg:252,bg:-1,hl:255,fg+:255,bg+:238,hl+:255,info:245,prompt:252,pointer:255,marker:255,spinner:245,header:240"

# Force tree to use colors (inheriting your monochrome LS_COLORS)
alias tree="tree -C"

# Force tree to render in monochrome white/gray
alias tree="tree -C --nolinks"
export TREE_COLORS="di=37:ln=36:so=35:pi=33:ex=32:bd=33:cd=33:su=37:sg=37:tw=30;47:ow=30;47:"

# Force tree to monochrome by clearing out colored file-type mappings
export LS_COLORS="${LS_COLORS}:ex=00;37:fi=00;252:"

# Comprehensive Monochrome LS_COLORS override for tree, ls, and lsd
export LS_COLORS="rs=0:di=01;37:ln=01;248:mh=00:pi=40;240:so=01;240:do=01;240:bd=40;240:cd=40;240:or=40;240:mi=00:su=37;240:sg=30;240:ca=30;240:tw=30;240:ow=34;240:st=37;240:ex=01;37:*.tar=01;248:*.tgz=01;248:*.arc=01;248:*.arj=01;248:*.taz=01;248:*.lha=01;248:*.lz4=01;248:*.lzh=01;248:*.lzma=01;248:*.tlz=01;248:*.txz=01;248:*.tzo=01;248:*.t7z=01;248:*.zip=01;248:*.z=01;248:*.dz=01;248:*.gz=01;248:*.lrz=01;248:*.lz=01;248:*.lzo=01;248:*.xz=01;248:*.zst=01;248:*.tzst=01;248:*.bz2=01;248:*.bz=01;248:*.tbz=01;248:*.tbz2=01;248:*.tz=01;248:*.deb=01;248:*.rpm=01;248:*.jar=01;248:*.war=01;248:*.ear=01;248:*.sar=01;248:*.rar=01;248:*.alz=01;248:*.ace=01;248:*.zoo=01;248:*.cpio=01;248:*.7z=01;248:*.rz=01;248:*.cab=01;248:*.wim=01;248:*.swm=01;248:*.dwm=01;248:*.esd=01;248:*.jpg=01;245:*.jpeg=01;245:*.mjpg=01;245:*.mjpeg=01;245:*.gif=01;245:*.bmp=01;245:*.pbm=01;245:*.pgm=01;245:*.ppm=01;245:*.tga=01;245:*.xbm=01;245:*.xpm=01;245:*.tif=01;245:*.tiff=01;245:*.png=01;245:*.svg=01;245:*.svgz=01;245:*.mng=01;245:*.pcx=01;245:*.mov=01;245:*.mpg=01;245:*.mpeg=01;245:*.m2v=01;245:*.mkv=01;245:*.webm=01;245:*.ogm=01;245:*.mp4=01;245:*.m4v=01;245:*.mp4v=01;245:*.vob=01;245:*.qt=01;245:*.nuv=01;245:*.wmv=01;245:*.asf=01;245:*.rm=01;245:*.rmvb=01;245:*.flc=01;245:*.avi=01;245:*.fli=01;245:*.flv=01;245:*.gl=01;245:*.dl=01;245:*.xcf=01;245:*.xwd=01;245:*.yuv=01;245:*.cgm=01;245:*.emf=01;245:*.ogv=01;245:*.ogx=01;245:*.aac=00;242:*.au=00;242:*.flac=00;242:*.m4a=00;242:*.mid=00;242:*.midi=00;242:*.mka=00;242:*.mp3=00;242:*.mpc=00;242:*.ogg=00;242:*.ra=00;242:*.wav=00;242:*.oga=00;242:*.opus=00;242:*.spx=00;242:*.xspf=00;242:"
