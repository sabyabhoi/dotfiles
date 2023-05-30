fish_add_path $HOME/scripts/
fish_add_path $HOME/workspace/instdir/eww/target/release/
fish_add_path $HOME/.local/bin/

set fish_greeting

fish_vi_key_bindings

alias l='n -de'
export NNN_PLUG='p:preview-tabbed;f:finder'
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_TMPFILE="/tmp/nnn.tmp"

set userfiles /home/cognusboi/workspace/userfiles

alias r=ranger
alias R='radian'
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

set college $userfiles/college
alias col='cd $college/'
alias general='cd $college/general'

alias dbms='cd $college/3-2/DBMS'
alias dsa='cd $college/3-2/DSA'
alias mpi='cd $college/3-2/MPI'
alias fm='cd $college/3-2/FM'
alias ae='cd $college/3-2/Applied_Econometrics'
alias pftp='cd $college/3-2/PFTP'
alias eapp='cd $college/3-2/EAPP'

alias m480='mpv --ytdl-format="best[height<=480]"'
#alias m720='mpv --ytdl-format="best[height<=720]"'
alias m1080='mpv --ytdl-format="best[height<=1080]"'

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

