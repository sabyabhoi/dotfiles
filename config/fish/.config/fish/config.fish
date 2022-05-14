fish_add_path $HOME/scripts/
fish_add_path $HOME/.cargo/bin/
fish_add_path $HOME/workspace/instdir/eww/target/release/
fish_add_path $HOME/.local/bin/

set fish_greeting
fish_vi_key_bindings

# NNN 
alias l='nnn -de'
export NNN_PLUG='p:preview-tui;f:finder'
export NNN_FIFO="/tmp/nnn.fifo"

# Aliases

set userfiles /home/cognusboi/workspace/userfiles

alias r=ranger
alias vim=nvim
alias hx=helix
alias lg=lazygit
alias vms='cd $userfiles/VMs/'
alias dots='cd $userfiles/dotfiles/'
alias docs='cd $userfiles/Media/Docs/'
alias orgs='cd $userfiles/orgfiles/'
alias pro='cd $userfiles/programming/'
alias misc='cd $userfiles/misc/'
alias music='cd ~/Music/'
alias say='pyfiglet -f roman $1'

# College
set college $userfiles/college
alias col='cd $college/'
alias ir='cd $college/IR'
alias mcom='cd $college/MCOM'
alias pom='cd $college/POM'
alias behav='cd $college/behav'
alias general='cd $college/general'
alias macro='cd $college/macro'
alias micro='cd $college/micro'
alias econ='cd $college/econometrics'
alias egd='cd $college/EGD'

