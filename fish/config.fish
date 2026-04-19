if status is-interactive
    set fish_greeting ""
    starship init fish | source
    fastfetch
end

alias ls='eza --icons=always -a'
alias cls='clear'
alias cd='z'
alias cat='bat'
alias zed='zeditor'
alias hx='/opt/helix/hx'

set -gx EDITOR nvim

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

fish_add_path /home/agent/.spicetify
zoxide init fish | source

function live
    command live-server --browser=google-chrome-stable $argv
end

function fish_command_not_found
    set cmd $argv[1]

    # Check if the directory already exists
    if test -d "$cmd"
        set_color cyan
        echo "📂 Directory "(set_color blue)"'$cmd'"(set_color cyan)" exists. Changing directory..."
        set_color normal
        cd "$cmd"
        return 0
    end

    # Ignore weird inputs (added '/' to regex to support paths)
    if not string match -qr '^[a-zA-Z0-9./_-]+$' -- $cmd
        set_color red
        echo "✖ Command not found: $cmd"
        set_color normal
        return 127
    end

    # Build colored prompt using command substitution
    set -l prompt_str (set_color blue)"❯ "(set_color cyan)"'$cmd'"(set_color magenta)" is not a command. Create directory? [y/N] "(set_color normal)

    # Proper inline prompt
    read -l -P "$prompt_str" confirm

    switch (string lower $confirm)
        case y yes
            mkdir -p -- "$cmd"
            set_color green
            echo "✔ Created directory "(set_color blue)"'$cmd'"
            set_color normal

            # Automatically cd into the newly created directory
            cd "$cmd"
        case '*'
            # silent skip (clean UX)
    end

    return 127
end
