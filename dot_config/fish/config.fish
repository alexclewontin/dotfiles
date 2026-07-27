if set -q CLAUDECODE; or set -q GITHUB_COPILOT_VSCODE
    set -gx AGENT_MANAGED_SHELL 1
end

if set -q AGENT_MANAGED_SHELL
    set -gx PAGER cat
    set -gx GIT_PAGER cat
    set -gx MANPAGER cat
    set -gx BAT_PAGER ''
end

set -gx PYENV_ROOT "$HOME/.pyenv"
set -gx SSH_KEY_PATH "$HOME/.ssh/rsa_id"
set -gx EDITOR vim
set -gx EZA_CONFIG_DIR "$HOME/.config/eza"
set -gx BAT_CONFIG_DIR "$HOME/.config/batcat"
set -gx GOPATH "$HOME/.go"

test -d "$HOME/bin"; and set -gx PATH "$HOME/bin" $PATH
test -d "$HOME/.local/bin"; and set -gx PATH "$HOME/.local/bin" $PATH
test -n "$PYENV_ROOT"; and test -d "$PYENV_ROOT/bin"; and set -gx PATH "$PYENV_ROOT/bin" $PATH
test -n "$GOPATH"; and test -d "$GOPATH/bin"; and set -gx PATH "$GOPATH/bin" $PATH
test -d /opt/homebrew/bin; and set -gx PATH /opt/homebrew/bin $PATH
if test -d /opt/homebrew/opt/rustup/bin
    set -gx PATH /opt/homebrew/opt/rustup/bin "$HOME/.cargo/bin" $PATH
end

set -gx GPG_TTY (tty)
if set -q SSH_CONNECTION
    set -gx PINENTRY_USER_DATA USE_CURSES=1
end
command -sq gpg-connect-agent; and gpg-connect-agent updatestartuptty /bye >/dev/null 2>/dev/null

if command -sq pyenv
    pyenv init - fish | source
    pyenv virtualenv-init - fish | source
end

if command -sq rbenv
    rbenv init - fish | source
end

if command -sq eza
    if not set -q AGENT_MANAGED_SHELL
        alias ls="eza -G"
    end
    alias ll="eza -alh"
    alias la="eza -a"
    alias lla="eza -alh"
    alias lt="eza -aTL 2 --ignore-glob=.git"
    alias lt2="eza -aTL 2 --ignore-glob=.git"
    alias lt3="eza -aTL 3 --ignore-glob=.git"
    alias lt4="eza -aTL 4 --ignore-glob=.git"
end

if not set -q AGENT_MANAGED_SHELL
    if command -sq batcat
        alias cat="batcat"
    else if command -sq bat
        alias cat="bat"
    end
end

if not set -q AGENT_MANAGED_SHELL
    function cdls
        builtin cd $argv; and pwd; and ls
    end

    function cd
        cdls $argv
    end
end

command -sq sudoedit; or alias sudoedit="sudo -e"
alias bd="cd .."
alias dotconfig="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
command -sq gvim; and alias vim="gvim -v"

function targz --description "Create a gzip tarball"
    tar -czvf "$argv[1].tar.gz" $argv
end

function tarxz --description "Create an xz tarball"
    tar -cJvf "$argv[1].tar.xz" $argv
end

function tarbz --description "Create a bzip2 tarball"
    tar -cjvf "$argv[1].tar.bz" $argv
end

function untar --description "Extract a tarball into a named directory"
    test (count $argv) -gt 0; or return 1
    set -l dir (string replace -r '\.tar.*$' '' (basename $argv[1]))
    mkdir -p $dir
    tar -xvf $argv[1] -C $dir
end
