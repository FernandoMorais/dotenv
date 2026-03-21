if [ -f /opt/homebrew/bin/direnv ]; then
  # Hook direnv into the shell
  eval "$(direnv hook zsh)"
fi
