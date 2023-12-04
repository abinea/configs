if status is-interactive
    # Commands to run in interactive sessions can go here
end

# beautify prompt
starship init fish | source

# proxy settings
set -x winip (ip route | grep default | awk '{print $3}')
set port 10811 # v2ray
set proxy_http "http://$winip:$port"
function proxy --description "set wsl terminal proxy"
    set -gx ALL_PROXY $proxy_http
    set -gx HTTP_PROXY $proxy_http
    set -gx HTTPS_PROXY $proxy_http
    git config --global http.proxy $proxy_http
    git config --global https.proxy $proxy_http
end
function unproxy --description "unset wsl terminal proxy"
    set -e ALL_PROXY
    set -e HTTP_PROXY
    set -e HTTPS_PROXY
    git config --global --unset http.proxy
    git config --global --unset https.proxy
end
proxy

function mc -a dir --description "mkdir xx/ && cd xx/"
    if test (count $argv) -gt 1
        echo "Usage: mdc <dir>"
        echo "note: <dir> would be a unexisting directory"
    else
        if test -d $dir
            echo "Error: $dir already exists"
        else
            mkdir $dir && cd $dir
        end
    end
end
# PATH variables
# node version manager
fnm env --use-on-cd | source
set -x FNM_NODE_DIST_MIRROR 'https://npmmirror.com/mirrors/node'
# golang
set -x GOROOT /usr/lib/golang
set -x GOPATH $HOME/.go
set -x GOBIN $GOPATH/bin
set -x PATH $GOROOT/bin $GOBIN $PATH
# rust cargo
set -x PATH ~/.cargo/bin $PATH
# kotlin
set -x PATH ~/.sdkman/candidates/kotlin/current/bin $PATH


# aliases
alias python python3

alias ls exa
alias md mkdir
alias cat "bat -p"
set -x BAT_THEME OneHalfDark
alias lf 'joshuto --output-file /tmp/joshutodir; set LASTDIR (cat /tmp/joshutodir); cd "$LASTDIR"'

# abbr for performance
abbr nd "nr dev"
abbr o "code -r"
abbr fi "sudo dnf install"
abbr fun "sudo dnf uninstall"
abbr fs "dnf search"
