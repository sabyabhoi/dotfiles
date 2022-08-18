fish_add_path $HOME/scripts/
fish_add_path $HOME/.cargo/bin/
fish_add_path $HOME/workspace/instdir/eww/target/release/
fish_add_path $HOME/.local/bin/

set fish_greeting
fish_vi_key_bindings

# NNN 
alias l='n -de'
export NNN_PLUG='p:preview-tabbed;f:finder'
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_TMPFILE="/tmp/nnn.tmp"

# Aliases
set userfiles /home/cognusboi/workspace/userfiles

alias r=ranger
alias vim=nvim
alias hx=helix
alias lg=lazygit
alias vms='cd $userfiles/VMs/'
alias dots='cd $userfiles/dotfiles/'
alias docs='cd $userfiles/Media/Documents'
alias orgs='cd $userfiles/orgfiles/'
alias pro='cd $userfiles/programming/'
alias misc='cd $userfiles/misc/'
alias music='cd ~/Music/'
alias say='pyfiglet -f roman $1'

# College
set college $userfiles/college
alias col='cd $college/'
alias general='cd $college/general'

function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end 
        # tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end
