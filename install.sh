#!/usr/bin/env bash

set -e

###
### Setup
###

INSTALL_DIR=/usr/local;
LINK_DIR=${INSTALL_DIR}/bin;
NAME=dark-crystal;
TOOL=dark;

# colors
bold="\033[1m";
red="\033[0;31m";
olive="\033[0;32m";
green="\033[1;32m";
purple="\033[0;35m";
stop="\033[0m";

# Banners for completion of install

function dark_crystal_banner_narrow () {
  echo "$purple";
  cat <<-NARROW
    _   _   _     _   _   _   _
   / \ / \ / \   / \ / \ / \ / \\
  ( T | h | e ) ( D | a | r | k )
   \_/ \_/ \_/   \_/ \_/ \_/ \_/

     _   _   _   _   _   _   _
    / \ / \ / \ / \ / \ / \ / \\
   ( C | r | y | s | t | a | l )
    \_/ \_/ \_/ \_/ \_/ \_/ \_/
NARROW
  echo $stop;
}

function dark_crystal_banner_wide () {
  echo "$purple";
  cat <<-WIDE
       .....                                           ....                                         ..
  .H8888888h.  ~-.    .uef^                      .xH888888Hx.                               < .z@8 :
  888888888888x  :> :d88E                      .H8888888888888:                   .u    .    !@88E
 X~     :?888888hx~ :888E            .u        888*---?--*88888X         u      .d88B :@8c   :888E   u
 :      x8.^ *88*    888E .z8k    ud8888.     :f     d8x.   ^%88k     us888u.  = 8888f8888r   888E u@8NL
  :-:- X8888x        888E~?888L :888:8888.    :>    <88888X   :?8  .@88  8888   4888>:88    888E: 88*
       488888>       888E  888E d888 :88%      ::..::888888>    8> 9888  9888    4888> :      888E .dN.
     .. :88*        888E  888E 8888.+                : *88     X  9888  9888    4888>        888E~8888
   x88888nX       .  888E  888E 8888L            .xHHhx..      !  9888  9888   .d888L .+     888E :888&
  ! *8888888n..  :   888E  888E :8888c. .+      X88888888hx. ..!   9888  9888   ^ 8888*       888E  9888.
 :    *88888888*   m888N= 888>   88888%       !    *888888888      888*..888      -Y-      :-888*- 4888:
         ^:***::     :Y:   888     :YP:               ^:***::       ^Y:   ^Y:                  :    :
                          J88:
                          @%
                        ::
                ...                                       .x+=:.        s                      ..
             xH88::~ .x8X                   ..           z:    ^%      :8                x .d88:
           :8888   .f:8888Hf    .u    .    @L               .   <k    .88                 5888R
          :8888>  X8L  ^::   .d88B :@8c  9888i   .dL     .@8Ned8:   :888ooo       u      :888R
          X8888  X888h       =:8888f8888r :Y888k:*888.  .@^%8888:  -*8888888    us888u.    888R
          88888  !88888.       4888>:88:    888E  888I x88:  :)8b.   8888    .@88 :8888:   888R
          88888   %88888       4888> :      888E  888I 8888N=*8888   8888    9888  9888    888R
          88888 :> :8888>      4888>        888E  888I  %8:    R88   8888    9888  9888    888R
          :8888L %  ?888   !  .d888L .+     888E  888I   @8Wou 9%   .8888Lu= 9888  9888    888R
           :8888  :-*:   /   ^:8888*:     x888N><888: .888888P:    ^%888*   9888  9888   .888B .
             :888.      ::       :Y:        :88:  888  :   ^:F        :Y:    :888*:888:  ^*888%
               ::***~::                          88F                         ^Y:   ^Y:     :%
                                                 98:
                                               ./:
                                              ~:
WIDE
  echo "$stop";
}

# Test for requirements

missingRequirements=

command -v git > /dev/null || {
  echo "$red$bold  Missing Git $stop";
  echo      "$red  more information at";
  echo          "  http://git-scm.com";
  echo          "  ------------------- $stop";
  echo "  Git can downloaded from$red http://git-scm.com/downloads$stop";
  echo
missingRequirements=true
}

command -v node > /dev/null && command -v npm >/dev/null || {
  echo "$red$bold  Missing node and/or npm $stop";
  echo      "$red  more information at";
  echo          "  http://nodejs.org/";
  echo          "  ------------------------ $stop";
  echo "  Node and npm can be downloaded from$red http://nodejs.org/download/$stop";
  echo
missingRequirements=true
}

command -v grunt > /dev/null || {
  echo "$red$bold  Missing grunt-cli $stop";
  echo      "$red  more information at";
  echo          "  http://gruntjs.com/getting-started";
  echo          "  ---------------------------------- $stop";
  echo "  Grunt-cli can be installed by running$red npm install -g grunt-cli $stop";
  echo
missingRequirements=true
}

command -v bower > /dev/null || {
  echo "$red$bold  Missing Bower $stop";
  echo      "$red  more information at";
  echo          "  http://bower.io/";
  echo          "  -------------------$stop";
  echo "  Bower can be installed by running$red npm install -g bower $stop";
missingRequirements=true
}

command -v zsh > /dev/null || {
  echo "$red$bold  Missing zsh $stop";
  echo      "$red  more information at";
  echo          "  http://www.zsh.org/";
  echo          "  -------------------$stop";
  echo "  zsh can be downloaded from$red http://sourceforge.net/projects/zsh/files/$stop";
missingRequirements=true
}
test $missingRequirements && exit 1;

test -d $INSTALL_DIR && command -v curl > /dev/null && {
  echo "${green}Installing Dark Crystal in $INSTALL_DIR/$NAME/$stop";

  cd $INSTALL_DIR;

  echo "${green}Cloning dark-crystal$stop";
  git clone https://github.com/upright-netizen/$NAME.git

  echo "${green}Symlinking to /usr/local/bin/$stop";
  ln -s $INSTALL_DIR/$NAME/bin/$NAME $LINK_DIR/$TOOL
  chmod 755 $LINK_DIR/$TOOL;

  echo "${olive}done$stop";
  echo

  width=$(tput cols);

  if test $width -gt 90; then
    dark_crystal_banner_wide;
  fi

  if test $width -gt 39 && test $width -lt 90; then
    dark_crystal_banner_narrow;
  fi

  echo
  echo "Dark Crystal installed in $purple$INSTALL_DIR/$stop";
  echo
  echo "Dark Crystal tools linked in $purple$LINK_DIR/$TOOL$stop";
  echo
  echo "Make sure that $LINK_DIR is on your \$PATH";
  echo
  echo "type ${purple}${bold}dark${stop} to invoke it's wonders";
}