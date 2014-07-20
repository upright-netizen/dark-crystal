#!/usr/bin/env zsh

#              .oooooo.                                                                                          .
#             d8P'  `Y8b                                                                                       .o8
#            888           .ooooo.  ooo. .oo.  .oo.   oo.ooooo.   .ooooo.  ooo. .oo.    .ooooo.  ooo. .oo.   .o888oo
#            888          d88' `88b `888P"Y88bP"Y88b   888' `88b d88' `88b `888P"Y88b  d88' `88b `888P"Y88b    888
#            888          888   888  888   888   888   888   888 888   888  888   888  888ooo888  888   888    888
#            `88b    ooo  888   888  888   888   888   888   888 888   888  888   888  888    .o  888   888    888 .
#             `Y8bood8P'  `Y8bod8P' o888o o888o o888o  888bod8P' `Y8bod8P' o888o o888o `Y8bod8P' o888o o888o   "888"
#                                                      888
#                                                     o888o

function install_component_dependencies {
  #
  # npm install
  #

  log
  log "NPM install" -c "green";
  log

  # make a node_modules folder locally so they don't get installed somewhere else on the path
  test -d node_modules || mkdir -p node_modules;

  # install grunt contrib plugins
  npm install --save-dev grunt-contrib-jshint
  npm install --save-dev grunt-contrib-connect
  npm install --save-dev grunt-contrib-watch
  npm install --save-dev grunt-text-replace;

  log
  log "Bower install" -c "green";
  log

  bower install --save polymer;
}

function dark_crystal_generate_component_html {
  local webcomponent=$1

  log
  log "Creating src and dist folders" -c "green";
  log

  # make src and dist directories
  mkdir src dist;

  log
  log "Generating web component: " -c "green" -n;
  log "$webcomponent" -c "green";
  log

  # generate web component
  sed -e \
    "s;%COMPONENT%;$webcomponent;g" \
  "$resources/webcomponent.html.template" > "src/$webcomponent.html"

  # generate index.html
  sed -e \
    "s;%COMPONENT%;$webcomponent;g" \
  "$resources/component-index.html.template" > "index.html"
}

function dark_crystal_new_component {
  # ensure we have a name
  if [ -z "$1" ]; then
    log "Please supply a name." -c "yellow";
    return;
  fi

  local component=$1
  local classification=component

  dark_crystal_create_folder "$component";
  dark_crystal_generate_package_files $classification;
  dark_crystal_generate_gruntfile $classification;
  install_component_dependencies;
  dark_crystal_generate_html $classification "$component";

  log
  log "Done." -c "green";
  log
  log "New component created at " -c "green" -n;
  log "$(pwd)" -b -c "green";
  log
}
