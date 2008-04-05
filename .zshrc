# .zshrc written by t for 4.3.4 in 20071122
# vim:enc=utf8:

# ----------------------------------------
# add below to ~/.bash_profile:
#
# if [ -x /usr/bin/zsh ]; then
#   echo 'exec zsh'
#   exec /usr/bin/zsh -l
# else
#   echo 'exec zsh failed.'
# fi
#

# ----------------------------------------
# env
if [ $TERM = "cygwin" ]; then
  export LANG=ja_JP.SJIS
  export LC_ALL=C
  export SHELL=/usr/local/bin/zsh
  export PATH="/java/jdk1.6.0_03/bin:$PATH"
  export PATH="/cygdrive/f/app/prog/ghc/bin:$PATH"
else
  export LANG=ja_JP.UTF8
  unset LC_ALL
  export LC_MESSAGES=C
  export SHELL=`which zsh`
  export PATH="$HOME/bin:$PATH"
fi

if [ -x `which lv` ]; then
  export PAGER=lv
elif [ -x `which less` ]; then
  export PAGER=less
fi

export EDITOR=vim

# C-wで単語の一部と見なす記号
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# svn
export rep=file:///var/svn/

# ----------------------------------------
# aliases
setopt completealiases
if [ $TERM = "cygwin" ]; then
  alias ls='ls --show-control-chars --color=always -F'
  alias l='ls --show-control-chars --color=always -FAl'
  export LV='-Os -c'
else
  case $(uname) in
  'Linux')
    alias ls='ls --color=always -Fh'
    alias l='ls --color=always -FAlh'
    ;;
  'FreeBSD')
    alias ls='ls -GFh'
    alias l='ls -GFAlh'
    export LSCOLORS='ExfxcxdxBxegedabagacad'
    ;;
  esac
  export LV='-Ou8 -c'
fi
alias mv='mv -i'
alias quit='exit'
alias w3m='w3m -O ja_JP.UTF-8'
# for function cd
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
# shortcuts
alias -g ...='../../'
alias -g ....='../../../'
alias -g .....='../../../../'
alias x='exit'
alias a='./a.out'
alias m='make'
alias -g F='| grep -i'
alias -g GG='| xargs -0 grep -i'
alias -g G='| grep -i'
alias -g L='| lv'

# ----------------------------------------
# functions
function cd { builtin cd $@ ; ls }
function gd {
  dirs -v
  echo -n "select: "
  read nd
  if [ "$nd" != "" ]; then
    cd +"$nd"
  fi
}
function backup_dot_files {
  tar jcvf ~/'dotfiles_'`date +%Y%m%d`'.tar.bz2' ~/.vimrc ~/.zshrc /cygdrive/f/app/editor/gvim/{_vimrc,_gvimrc,vimrc,gvimrc,vimrc_local.vim,gvimrc_local.vim}
}
function ff {
  /cygdrive/f/app/internet/firefox/firefox $1 &
}

function backup {
  D=`pwd|sed -r 's/^.*\/(.*?)$/\1/'`
  F=${D}_`date +%Y%m%d_%H%M`.tar.gz
  make clean
  cd ..
  tar zcvf ${F} $D
  cd -
  echo "saved: ${F}"
}

# ----------------------------------------
# keybinds
bindkey -e
bindkey '^[[1~' beginning-of-line # Home
bindkey '^[[4~' end-of-line # End
bindkey '^T' kill-word
bindkey '^U' backward-kill-line
bindkey '^[[3~' delete-char-or-list # Del
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# ----------------------------------------
# history
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt appendhistory
setopt histignorealldups
setopt histnofunctions
setopt histnostore
setopt histreduceblanks
setopt share_history

# ----------------------------------------
# zsh
setopt noclobber # 存在するファイルにリダイレクトしない
setopt autocd
setopt autopushd
setopt pushdignoredups
setopt ignoreeof # C-Dでログアウトしない
setopt print_eightbit # multibyte characters
setopt noflowcontrol # C-S C-Q

# ----------------------------------------
# hooks
function chpwd() {
  print -Pn "\e]2;%~ [%m]\a"
}

# ----------------------------------------
# prompt
autoload -U colors
colors
local C_PRE="%{$fg[cyan]%}"
local C_CMD="%{$reset_color%}%{$fg[white]%}"
local C_RIGHT="%{$bg[black]%}%{$fg[white]%}"
local C_DEFAULT="%{$reset_color%}"
if [ $TERM = "cygwin" ]; then
  # for Cygwin (ps 1.11)
  function joblist { ps|awk '/^S/{print gensub(/^.*\/(.*?)$/,"\\1", "", $9);}'|sed ':a;$!N;$!b a;;s/\n/,/g' }
  function jobnum { ps|awk '/^S/{print}'|wc -l}
else
  # for Linux (procps 3.2.6)
  function joblist { ps -l|awk '/^..T/&&NR!=1{print $14}'|sed ':a;$!N;$!b a;;s/\n/,/g' }
  function jobnum { ps -l|awk '/^..T/&&NR!=1{print}'|wc -l}
fi
function precmd {
  local jn=$(jobnum)
  if [[ "$jn" -gt 0 ]]; then
    prompt "[$jn] "`joblist`
  else
    prompt ''
  fi
}
function prompt {
  PROMPT=$C_PRE"%S[%n] %~ %s "$1"
"$C_PRE"%# "
}
prompt ""
RPROMPT="%S"$C_RIGHT"[%m] %D{%d %a} %*%s"$C_CMD
POSTEDIT=`echotc se`
setopt prompt_subst # 色
unsetopt promptcr

# ----------------------------------------
# completion
autoload -U compinit
compinit -u

# ls, colors in completion
export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=1;31:bd=46;34:cd=43;34:su=41;30:tw=42;30:ow=43;30'
#zstyle ':completion:*' list-colors 'di=1;34' 'ln=35' 'so=32' 'ex=1;31' 'bd=46;34'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:default' menu select=1 # C-P/C-N
setopt nolistbeep # 曖昧補完でビープしない
setopt autolist # 補完時にリスト表示
setopt listtypes
unsetopt menucomplete # 最初から候補を循環する
setopt automenu # 共通部分を補完しそれ以外を循環する準備
setopt extendedglob # 展開で^とか使う
setopt numericglobsort # 数字展開は数値順

setopt autoparamkeys # 補完後の:,)を削除
fignore=(.o .swp) # 補完で無視する

# ssh
function print_known_hosts() {
  if [ -f $HOME/.ssh/known_hosts ]; then
    cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
  fi
}
_cache_hosts=($(print_known_hosts))

# 補完の種類
compctl -c man where
compctl -o setopt
compctl -s '$(setopt)' unsetopt # 設定されているオプション
compctl -v vared unset export
compctl -g '*(-/)' cd
compctl -b bindkey
compdef -d java

_cache_hosts=(localhost $HOST 192.168.2.111 hs.utsurigi.net)
