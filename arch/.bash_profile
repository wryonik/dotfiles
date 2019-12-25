#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

