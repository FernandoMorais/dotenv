if [ -f /etc/bash_completion.d/azure-cli ]; then
    source /etc/bash_completion.d/azure-cli
else
    [[ -f "${HOME}/lib/azure-cli/az.completion" ]] && source ${HOME}/lib/azure-cli/az.completion

    if [ -f "$(brew --prefix)/etc/bash_completion.d/az" ]; then
        autoload bashcompinit && bashcompinit
        source "$(brew --prefix)/etc/bash_completion.d/az"
    fi
fi
