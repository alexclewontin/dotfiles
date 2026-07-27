# acl theme port — no RPROMPT; ⍉ moved to left prompt

# git prompt config (set at file scope so fish picks them up at startup)
set -g __fish_git_prompt_showdirtystate true
set -g __fish_git_prompt_showcolorhints true
set -g __fish_git_prompt_color_branch green
set -g __fish_git_prompt_char_cleanstate ' ✔'
set -g __fish_git_prompt_char_dirtystate ' ✗'
set -g __fish_git_prompt_color_cleanstate green
set -g __fish_git_prompt_color_dirtystate red

function fish_prompt
    set -l last_status $status

    # blank line before each prompt (mirrors precmd _newline)
    echo

    # user@host — SSH or su only
    if set -q SSH_CONNECTION
        set_color blue
        echo -n $USER@$hostname:
        set_color normal
    else if test "$LOGNAME" != "$USER"
        set_color blue
        echo -n $USER:
        set_color normal
    end

    # path — bold green, abbreviated past 65 chars
    set_color --bold '#87c3a7'
    if test (string length -- $PWD) -gt 65
        echo -n (prompt_pwd --full-length-dirs 3)
    else
        echo -n (prompt_pwd --full-length-dirs 99)
    end
    set_color normal
    echo -n ' '

    # git info
    echo -n (fish_git_prompt 'Git: %s')

    # python + ruby on line 1 (right side, mirrors zsh RPROMPT placement)
    if command -sq pyenv
        set -l pyver (pyenv version-name 2>/dev/null)
        if test -n "$pyver"
            set_color '#c3b98d'
            echo -n " Python: $pyver"
            set_color normal
        end
    end
    if command -sq rbenv
        set -l rbver (rbenv version-name 2>/dev/null)
        if test -n "$rbver"
            set_color '#c3b98d'
            echo -n " Ruby: $rbver"
            set_color normal
        end
    end

    echo # end line 1

    # ⍉ on non-zero exit (moved from RPROMPT)
    if test $last_status -ne 0
        set_color --bold red
        echo -n '⍉ '
        set_color normal
    end

    # prompt character
    if fish_is_root_user
        echo -n '# '
    else
        echo -n '$ '
    end
end

function fish_mode_prompt
    # suppress vi mode indicator (no vi-mode plugin equivalent loaded)
end
