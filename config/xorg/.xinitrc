#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export XDG_CONFIG_HOME=/home/cognusboi/.config
export XDG_RUNTIME_DIR=$(mktemp -d)
export TERMINAL=kitty
export SCRIPTS=/home/cognusboi/scripts
export SHELL=/bin/fish
export BROWSER=brave
export EDITOR=nvim
export VISUAL=nvim

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH 

export DENO_INSTALL="/home/cognusboi/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME='/usr/lib/jvm/java-18-openjdk'
export PATH=$JAVA_HOME/bin:$PATH 

export ANDROID_HOME=/opt/android-sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH# Android emulator PATH
export PATH=$ANDROID_HOME/emulator:$PATH# Android SDK ROOT PATH
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$ANDROID_SDK_ROOT:$PATH

export PATH=/home/cognusboi/workspace/instdir/nnn:$PATH

picom --config=$XDG_CONFIG_HOME/picom/picom.conf -b
~/.fehbg

pipewire & 
pipewire-pulse &
wireplumber &

xbindkeys --poll-rc
setxkbmap -option caps:swapescape
xset r rate 200 25

$SCRIPTS/takeabreak.sh &

exec qtile start
