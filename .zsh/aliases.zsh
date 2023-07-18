# Alias
# ---
#
alias k="kubectl"
alias h="helm"
alias tf="terraform"
alias a="ansible"
alias ap="ansible-playbook"
alias dnt="dotnet"

# BASH
alias ll='ls -lah'
alias cls="clear; printf '\033[3J'"

# GIT
alias gg='git status --long'
alias gd='git diff'
alias gl='git log'
alias gls='git log --pretty=oneline'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gpl='git pull'
alias gplr='git pull -r'
alias gti='git'
alias gt="git tag"
alias gts="git tag |grep "
gts-clean(){
    tag="${1}"
    skip="${2:-none}"
    remote="${3:-origin}"

    to_clean=$(gts $tag)
    to_remove=$(echo $to_clean |wc -l)

    if [ "$to_clean" = "" ]; then
        to_remove=0
    elif [ "$skip" = "last" ]; then
        to_remove=$(expr $to_remove - 1)
        to_clean=$(echo $to_clean |tail -n $to_remove)
    fi

    header=$(echo "Pattern: $tag -> Remote: $remote -> Skip: $skip")
    length=${#header}

    if [ $to_remove = 0 ]; then
        print-table $header "No tags to be removed."
    else
        print-table $header $to_clean
        
        echo "Are you sure to remove tags? [y/N] "
        read answer
        if [ "$answer" != "${answer#[Yy]}" ] ;then 
            echo -n $to_clean | while read line || [[ -n $line ]];
            do
                echo "Removing $line..."
                git push --delete $remote $line
                git tag -d $line
                echo "> done!"
            done
        fi
    fi
}

print-table(){
    header=${1}
    lines=${2}

    max_length=${#header}

    echo -n $lines | while read line || [[ -n $line ]];
    do
        length=${#line}
        if (( length > max_length )); then
            max_length=$length
        fi
    done

    separator=$(printf "%0.s-" $(seq 1 $(expr $max_length + 2)))

    echo " $separator"
    printf "| %-${max_length}s |\n" "$header"
    echo " $separator"
    echo -n $lines | while read line || [[ -n $line ]];
    do
        printf "| %-${max_length}s |\n" "$line"
    done
    echo " $separator"
}

# DOCKER
alias dkr="docker"
alias dkp="docker ps"
alias dki="docker images"
alias dknone="docker images | grep '^<none>' | awk '{print \$3}'"
alias dkclear="docker rmi \$(dknone)"

# KUBERNETES
alias kub="kubectl"
alias kuba="kubectl apply"
alias kubaf="kubectl apply -f"
alias kubd="kubectl delete"
alias kubdf="kubectl delete -f"

