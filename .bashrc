# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt:
export PS1="\[\033[1;32m\]\u\[\033[1;36m\]@\\[\033[2;31m\]\h:\[\033[0;36m\]\w\\[\033[2;32m\] \`parse_git_branch\`\\n \[\033[00m\]"

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

export PATH="$PATH:~/.forbidden_library/radio_pirating/scripts/"
# Aliases
alias enter-secrets='encfs ~/.crypt ~/crypt && cd ~/crypt && ls -la'
alias exit-secrets='fusermount -u ~/crypt'
alias vim='nvim'
alias ls='lsd --group-directories-first'
alias l='lsd --group-directories-first'
alias cal='cal -m'
alias cd...='cd ../..'
alias swayfig='vim ~/.config/sway/config'
#alias cdl='function _cdl(){ cd "$1" && ls; }; _cdl'
alias yt-mp3='yt-dlp -x --audio-format mp3 --audio-quality 0'
alias wgetit='wget -r -np -nH'
# Aliases for xbps
alias otsi='sudo xbps-query -Rs '
alias lisa='sudo xbps-install '
alias eemalda='sudo xbps-remove -ROo '
alias uuenda='sudo xbps-install -Su'
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
#git
alias gitit='git add . && git commit -m "$(read -p "Enter commit message: " msg && echo "$msg")" && git push'
# Kood/Jõhvi
alias movies='cdl /home/hazgal/koodjohvi/Study/modules/Coding_Fundamentals/movie-api'
alias itinerary='cdl ~/koodjohvi/Study/modules/Coding_Fundamentals/itinerary/ && vim *.java'
alias javascript='cdl ~/koodjohvi/Study/modules/javascript-sprint/'
alias learnjavascript='cd ~/Downloads/JavaScript\ -\ The\ Complete\ Guide\ 2023\ \(Beginner\ +\ Advanced\)/ && ranger'
alias racetrack='cd ~/koodjohvi/Study/modules/racetrack'
alias lessonlock='cd ~/koodjohvi/defhack/ && ls -la'
alias typescript='cdl ~/koodjohvi/Study/modules/ts-sprint/'
#bash autocd
shopt -s autocd

# et autocd annaks ka ls'i
#cd() {
#  command cd "$@" && ls -l
#}

flatpaks=$(flatpak list --app --columns=application)
for uri in $flatpaks; do
  uriParts=($(echo $uri | tr '.' ' '))
  name=$(echo ${uriParts[-1]} | tr '[:upper:]' '[:lower:]')
  alias $name="&>/dev/null flatpak run $uri &"
done

cdl() {
  cd "$1" && ls -l
}

# GIT STATUS AT BASH PROMPT
# get current branch in git repo
function parse_git_branch() {
  BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ ! "${BRANCH}" == "" ]; then
    STAT=$(parse_git_dirty)
    echo "(${BRANCH}${STAT})"
  else
    echo ""
  fi
}

# get current status of git repo
function parse_git_dirty {
  status=$(git status 2>&1 | tee)
  dirty=$(
    echo -n "${status}" 2>/dev/null | grep "modified:" &>/dev/null
    echo "$?"
  )
  untracked=$(
    echo -n "${status}" 2>/dev/null | grep "Untracked files" &>/dev/null
    echo "$?"
  )
  ahead=$(
    echo -n "${status}" 2>/dev/null | grep "Your branch is ahead of" &>/dev/null
    echo "$?"
  )
  newfile=$(
    echo -n "${status}" 2>/dev/null | grep "new file:" &>/dev/null
    echo "$?"
  )
  renamed=$(
    echo -n "${status}" 2>/dev/null | grep "renamed:" &>/dev/null
    echo "$?"
  )
  deleted=$(
    echo -n "${status}" 2>/dev/null | grep "deleted:" &>/dev/null
    echo "$?"
  )
  bits=''
  if [ "${renamed}" == "0" ]; then
    bits=">${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="*${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="+${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="?${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="x${bits}"
  fi
  if [ "${dirty}" == "0" ]; then
    bits="!${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
