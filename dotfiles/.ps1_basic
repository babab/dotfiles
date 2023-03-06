# vim: set ft=sh:

exitcode_ps1()
{
    if [ $1 -gt 0 ]; then
        echo " err:$1"
    fi
}

sshkey_ps1()
{
    ssh-add -l >/dev/null 2>&1
    case $? in
        0)
            echo "+"
            ;;
        1)
            echo "-"
            ;;
        2)
            echo "n/a"
            ;;
    esac
}

PS1="\[$(tput bold; tput setaf 1)\]\n\u\
\[$(tput op)\] at \
\[$(tput setaf 3)\]\h\
\[$(tput setaf 1)\]\$(exitcode_ps1 \$?)\
\[$(tput setaf 5)\] \!\
\[$(tput setaf 6)\] \$(sshkey_ps1)\
\[$(tput setaf 2)\]\n\w\
\[$(tput setaf 3)\]\$\[$(tput op; tput sgr0)\] "
