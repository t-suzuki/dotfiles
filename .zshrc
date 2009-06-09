# .zshrc written for 4.3.4 since 20071122
#
# vim:enc=utf8:
#
# history:
#   20090609: cd後のlsでファイル数が多すぎる場合に省略
#   20090606: 統合
#   20090404: psg追加, cd, gd等修正
#   20071122

# ----------------------------------------
# add below to ~/.bash_profile (exec zsh on login)
#        or to ~/.bashrc       (exec zsh for all bash)
#
# if [ -x /usr/bin/zsh ]; then
#   echo 'exec zsh'
#   exec /usr/bin/zsh -l
# else
#   echo 'exec zsh failed.'
# fi
#

# exists?
function exists() {
  which "$1" 1>/dev/null 2>&1
  if [ $? -eq 0 ]; then echo "0"; else echo ""; fi
}

# ----------------------------------------
# env
if [ $TERM = "cygwin" ]; then
  export LANG=ja_JP.SJIS
  export LC_ALL=C
  export SHELL=/usr/local/bin/zsh
  export PATH="/java/jdk1.6.0_03/bin:$PATH"
  export PATH="/cygdrive/f/app/prog/ghc/bin:$PATH"
else
  export LANG=ja_JP.UTF-8
  unset LC_ALL
  export LC_MESSAGES=C
  export SHELL=`which zsh`
  export PATH="$HOME/bin:$PATH"
fi

if [ -n "$(exists lv)" ]; then
  export PAGER=lv
elif [ -n "$(exists less)" ]; then
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
alias ':q'='exit'
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
alias man='man'
alias jman="LC_MESSAGES=$LANG man"
alias -g F='| grep -i'
alias -g GG='| xargs -0 grep -i'
alias -g G=' 2>&1 | grep -i'
alias -g L=" 2>&1 | $PAGER"
alias T='tail -n 50 -f'
# short commands
alias psp='ps -F ax'
# ssh-agent wrapper
test -n "$(exists lazy-ssh-agent)" && eval `lazy-ssh-agent setup ssh scp sftp`


# ----------------------------------------
# colors
autoload -U colors
colors

# ----------------------------------------
# functions
function ll {
  # super list
  l "$@" | $PAGER
}

function cd {
  builtin cd $@
  if [ "$?" -eq 0 ]; then
    lscdmax=40
    rawls=/bin/ls
    nfiles=$($rawls|wc|awk '{print $1}')
    if [ $nfiles -eq 0 ]; then
      nfiles=$($rawls -A|wc|awk '{print $1}')
      if [ $nfiles -eq 0 ]; then
        echo "$fg[yellow]no files in: $(pwd)$reset_color"
      else
        echo "$fg[yellow]only hidden files in: $(pwd)$reset_color"
        ls -A
      fi
    elif [ $lscdmax -ge $nfiles ]; then
      ls
    else
      echo "$fg[yellow]$nfiles files in: $(pwd)$reset_color"
    fi
  fi
}

function gd {
  # usage: gd 2
  # usage: gd (prompt..)
  if [ "$#" -ge 1 ]; then cd +"$1"; return ; fi
  dirs -v
  echo -n "select: "
  read nd
  if [ "$nd" != "" ]; then
    cd +"$nd"
  fi
}

function psg {
  # ps aux | grep ... but do not include ps nor grep
  HEAD=$(ps aux | head -n 1) # header
  COMMANDPOS=$(echo $HEAD | sed -r 's@COMMAND$@@' | wc -m) # where 'COMMAND' begins
  COMMANDPOS=$(($COMMANDPOS-1))
  ps aux | while read LINE; do
    echo $LINE | grep -v -E "^.{${COMMANDPOS}}"'(ps aux|grep)' >/dev/null # not ps|grep
    if [ "$?" -ne 0 ]; then continue; fi
    echo $LINE | grep $*
  done
}

function backup {
  D=`pwd|sed -r 's/^.*\/(.*?)$/\1/'`
  F=${D}_`date +%Y%m%d_%H%M`.tar.gz
  if [ -f 'Makefile' ]; then make clean; fi
  builtin cd ..
  tar zcvf ${F} $D
  builtin cd -
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
# directory up/back on Ctrl-6
function cdup() {
  echo
  cd ..
  zle reset-prompt
}
zle -N cdup
bindkey '^\^' cdup

# hjkl on completion
zmodload -i zsh/complist # -i: ignore errors (on duplicate load)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# ----------------------------------------
# history
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
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
#function chpwd() {
#  print -Pn "\e]2;%~ [%m]\a"
#}

# ----------------------------------------
# prompt
if [ $TERM = "cygwin" ]; then
  # for Cygwin (ps 1.11)
  function joblist { ps|awk '/^S/{print gensub(/^.*\/(.*?)$/,"\\1", "", $9);}'|sed ':a;$!N;$!b a;;s/\n/,/g' }
  function jobnum { ps|awk '/^S/{print}'|wc -l}
  function ipaddrs { ipconfig | grep 'IP Address' | sed 's/\. //g;s/.*: //g' | grep -v 127.0.0.1 | sed ':a;$!N;$!b a;;s/\n/, /g' }
else
  # for Linux (procps 3.2.6)
  function joblist { ps -l|awk '/^..T/&&NR!=1{print $14}'|sed ':a;$!N;$!b a;;s/\n/,/g' }
  function jobnum { ps -l|awk '/^..T/&&NR!=1{print}'|wc -l}
  function ipaddrs { /sbin/ifconfig | awk '/^ *inet addr:/{print $2}' | cut -d: -f2 | grep -v 127.0.0.1 | sed ':a;$!N;$!b a;;s/\n/, /g' }
fi
function precmd {
  local jn=$(jobnum)
  if [[ "$jn" -gt 0 ]]; then
    prompt "[$jn] "`joblist`
  else
    prompt ''
  fi
}
# control sequences for zsh prompt: n lines down, then n lines up
function prompt {
  if [ $UID -eq 0 ]; then
    local C_USERHOST="%{$bg[white]$fg[magenta]%}"
    local C_PROMPT="%{$fg[magenta]%}"
  else
    local C_USERHOST="%{$bg[black]$fg[cyan]%}"
    local C_PROMPT="%{$fg[cyan]%}"
  fi
  local C_PRE="%{$reset_color%}%{$fg[cyan]%}"
  local C_CMD="%{$reset_color%}%{$fg[white]%}"
  local C_RIGHT="%{$bg[black]%}%{$fg[white]%}"
  local C_DEFAULT="%{$reset_color%}"
  PROMPT=$C_USERHOST"%S[%n@%m] %~ %s$C_PRE "$1"
"$C_PROMPT"%# "$C_CMD
  RPROMPT="%S"$C_RIGHT" %D{%d %a} %* %s"$C_CMD
  # a few blank lines at the bottom
  echo -n -e "\n\n\n\033[3A"
}

prompt ""
POSTEDIT=`echotc se`
setopt prompt_subst # use colors in prompt
unsetopt promptcr

# ----------------------------------------
# completion
autoload -U compinit
compinit -u

export LISTMAX=20
# ls, colors in completion
export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=1;31:bd=46;34:cd=43;34:su=41;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:default' menu select=1 # C-P/C-N
setopt nolistbeep # 曖昧補完でビープしない
setopt autolist # 補完時にリスト表示
#setopt listpacked # compact list on completion # 不安定?
setopt listtypes
unsetopt menucomplete # 最初から候補を循環する
setopt automenu # 共通部分を補完しそれ以外を循環する準備
setopt extendedglob # 展開で^とか使う
setopt numericglobsort # 数字展開は数値順
#setopt magicequalsubst # completion after '=' # 不安定?

setopt autoparamkeys # 補完後の:,)を削除
fignore=(.o .swp lost+found) # 補完で無視する

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

_cache_hosts=(localhost $HOST)

