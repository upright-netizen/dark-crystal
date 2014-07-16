
#                        ooooo     ooo     .    o8o  oooo
#                        `888'     `8'   .o8    `"'  `888
#                         888       8  .o888oo oooo   888   .oooo.o
#                         888       8    888   `888   888  d88(  "8
#                         888       8    888    888   888  `"Y88b.
#                         `88.    .8'    888 .  888   888  o.  )88b
#                           `YbodP'      "888" o888o o888o 8""888P'

function dark_crystal_update {
  # WIP
  cd /usr/local/dark-crystal;
  git pull origin master;
  rm /usr/local/bin/dark;
  ln -s /usr/local/dark-crystal/bin/dark-crystal /usr/local/bin/dark;
}

function dark_crystal_uninstall {
  echo "${red}"
  read -p "Are you sure? " -n 1 -r
  echo
  echo "${stop}"
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    test -d /usr/local/dark-crystal && rm -rf /usr/local/dark-crystal;
    test -e /usr/local/bin/dark && rm /usr/local/bin/dark;
  fi
}

function dark_crystal_link {
  devLocation=${1:-~/Code/dark-crystal};

  test -d "$devLocation" && {
    echo
    echo "${green}Linking dev version of dark-crystal${stop}";
    echo
    rm /usr/local/bin/dark;
    ln -s "$devLocation"/bin/dark-crystal /usr/local/bin/dark;
    return;
  }

  echo "${yellow}Can't find location of dark crystal${stop}";
}