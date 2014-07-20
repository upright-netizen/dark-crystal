#!/usr/bin/env zsh

#                ooooooooo.                          .                 .
#                `888   `Y88.                      .o8               .o8
#                 888   .d88' oooo d8b  .ooooo.  .o888oo  .ooooo.  .o888oo oooo    ooo oo.ooooo.   .ooooo.
#                 888ooo88P'  `888""8P d88' `88b   888   d88' `88b   888    `88.  .8'   888' `88b d88' `88b
#                 888          888     888   888   888   888   888   888     `88..8'    888   888 888ooo888
#                 888          888     888   888   888 . 888   888   888 .    `888'     888   888 888    .o
#                o888o        d888b    `Y8bod8P'   "888" `Y8bod8P'   "888"     .8'      888bod8P' `Y8bod8P'
#                                                                          .o..P'       888
#                                                                          `Y8P'       o888o


function install_prototype_dependencies {
  #
  # npm install
  #

  echo
  echo "$green NPM install $stop";
  echo

  # make a node_modules folder locally so they don't get installed somewhere else on the path
  test -d node_modules || mkdir -p node_modules;

  npm install --save-dev grunt-contrib-connect;
  npm install --save-dev grunt-bower-requirejs;

  bower install --save requirejs
}

function create_prototype_folder {
  local folder="$1";

  if test -d "$folder"; then
    echo "$red$folder exists. Exiting";
    exit 1;
  fi

  cp -r "$resources/prototype" "$folder";
  cd "$folder";

  unset folder;
}

function generate_prototype_html {
  local name=$1

  echo
  echo "$green Generating index.html $stop";
  echo

  sed -e \
    "s;%PROTOTYPE%;$name;g" \
  "index.html.template" > "index.html"

  rm index.html.template;
}


function dark_crystal_new_prototype {
  # ensure we have a name
  if [ -z "$1" ]; then
    echo "$yellow Please supply the name. $stop";
    return;
  fi

  local name=$1
  local classification=prototype

  create_prototype_folder "$name";
  dark_crystal_generate_package_files $classification;
  install_prototype_dependencies;
  generate_prototype_html $name;



  echo
  echo "$green Done. $stop";
  echo
  echo "$olive New component created at $green$(pwd)$stop";
  echo
}

