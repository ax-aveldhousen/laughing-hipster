# vim: set ft=sh
alias cdp="cd -"
alias ..='cd ..'
alias pd="pushd $1"
# list files
alias ll='ls --color=always -l'

#rake
alias bake='bundle exec rake'
alias fbake='bundle exec rake clobber default test:xunit'
alias bakeserver='bundle exec rake clobber localci build_env=dev'
alias uberbake='~/uberbake.txt'

#tools
alias s='start Source/*.sln'
alias projects='cd /c/Projects'
alias resrc='source ~/.bash_aliases && source ~/.bashrc && source ~/.profile'
alias role='whoami -groups -fo list | grep -i'
alias fu='find ./ -type f -print0 | xargs -0 grep -n $1'

#git
alias gs='git status'

alias diff='git difftool'
alias diffc='git difftool --cached'
alias gpr='git pull --rebase'
alias gmt='git mergetool'
alias grc='git rebase --continue'
alias gk='git fetch origin; git remote prune origin; gitk --all &'
alias dlb='dml'
# delete merged local branches
function dml(){
  for b in `git branch --merged | grep -v \*`; do git branch -D $b; done
}

function clone()
{
  if [ -z "$1" ]
  then
    echo "Missing git repository url ending"
    echo "usage: clone 'git repository ending' ['target directory name']"
  else
    giturl="git@github.com:$1.git"

    if [ -z "$2" ]
    then
      # we DON'T HAVE a target directory
      git clone $giturl
    else
      # we HAVE a target directory
      git clone $giturl $2
    fi
  fi
}

function vim(){
  if [[ $# -eq 0 ]]; then
    gvim &
  else
    gvim --remote-tab-silent "$@" &
  fi
}
