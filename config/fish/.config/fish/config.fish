fish_add_path $HOME/scripts/
fish_add_path $HOME/workspace/instdir/eww/target/release/
fish_add_path $HOME/.local/bin/
fish_add_path $HOME/.local/share/gem/ruby/3.0.0/bin

set fish_greeting

fish_vi_key_bindings

alias l='n -de'
export NNN_PLUG='p:preview-tabbed;f:finder'
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_TMPFILE="/tmp/nnn.tmp"
export RUSTC_WRAPPER=sccache cargo install {$package}

set userfiles /home/cognusboi/workspace

alias r=ranger
#alias R='radian'
alias vim=nvim
alias lg=lazygit
#alias vms='cd $userfiles/VMs/'
#alias dots='cd $userfiles/dotfiles/'
#alias docs='cd $userfiles/Media/Documents'
#alias orgs='cd $userfiles/orgfiles/'
#alias pro='cd $userfiles/programming/'
#alias misc='cd $userfiles/misc/'
#alias music='cd ~/Music/'
#alias tock='$userfiles/Downloads/tock/target/release/tock -c -s'

set college $userfiles/college
#alias col='cd $college/'
#alias general='cd $college/general'

#alias daa='cd $college/4-2/DAA'
#alias compilers='cd $college/4-2/Compilers'
#alias net='cd $college/4-2/Networks'
#alias fram='cd $college/4-2/FRAM'
alias cat='bat'

alias m480='mpv --ytdl-format="best[height<=480]"'
#alias m720='mpv --ytdl-format="best[height<=720]"'
alias m1080='mpv --ytdl-format="best[height<=1080]"'

zoxide init --cmd cd fish | source

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
