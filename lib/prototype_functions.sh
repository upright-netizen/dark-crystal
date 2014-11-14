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

  log
  log "NPM install" -c "green";
  log

  # make a node_modules folder locally so they don't get installed somewhere else on the path
  test -d node_modules || mkdir -p node_modules;

  # dev dependencies
  npm install --save-dev gulp;
  npm install --save-dev gulp-less;
  npm install --save-dev gulp-watch;
  npm install --save-dev gulp-webserver;
  npm install --save-dev bower-requirejs;
  bower install --save requirejs;

  # dependencies
  npm install --save express

}

function create_prototype_folder {
  local folder="$1";

  if test -d "$folder"; then
    log "$folder exists. Exiting" -c "red";
    exit 1;
  fi

  cp -r "$resources/prototype" "$folder";
  cd "$folder";

  unset folder;
}

function generate_prototype_html {
  local name=$1

  log
  log "Generating index.html" -c "green";
  log

  sed -e \
    "s;%PROTOTYPE%;$name;g" \
  "index.html.template" > "index.html"

  rm index.html.template;
}


function dark_crystal_new_prototype {
  # ensure we have a name
  if [ -z "$1" ]; then
    log "Please supply a name." -c "yellow";
    return;
  fi

  local name=$1

  create_prototype_folder "$name";
  dark_crystal_generate_package_files;
  install_prototype_dependencies;
  generate_prototype_html "$name";

  log
  log "Done." -c "green";
  log
  log "New prototype created at " -c "green" -n;
  log "$(pwd)" -b -c "green";
  log
}

