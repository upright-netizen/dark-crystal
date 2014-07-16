
#              .oooooo.                                                                                          .
#             d8P'  `Y8b                                                                                       .o8
#            888           .ooooo.  ooo. .oo.  .oo.   oo.ooooo.   .ooooo.  ooo. .oo.    .ooooo.  ooo. .oo.   .o888oo
#            888          d88' `88b `888P"Y88bP"Y88b   888' `88b d88' `88b `888P"Y88b  d88' `88b `888P"Y88b    888
#            888          888   888  888   888   888   888   888 888   888  888   888  888ooo888  888   888    888
#            `88b    ooo  888   888  888   888   888   888   888 888   888  888   888  888    .o  888   888    888 .
#             `Y8bood8P'  `Y8bod8P' o888o o888o o888o  888bod8P' `Y8bod8P' o888o o888o `Y8bod8P' o888o o888o   "888"
#                                                      888
#                                                     o888o

function dark_crystal_install_component_dependencies {
  #
  # npm install
  #

  echo
  echo "$green NPM install $stop";
  echo

  # make a node_modules folder locally so they don't get installed somewhere else on the path
  test -d node_modules || mkdir -p node_modules;

  # install grunt contrib plugins
  npm install --save-dev grunt-contrib-jshint grunt-contrib-connect grunt-contrib-watch grunt-text-replace;

  echo
  echo "$green Bower install $stop";
  echo

  bower install;
}

function dark_crystal_generate_component_html {
  local webcomponent=$1

  echo
  echo "$green Creating src and dist folders $stop";
  echo

  # make src and dist directories
  mkdir src dist;

  echo
  echo "$green Generating web component: $webcomponent $stop";
  echo

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
    echo "$yellow Please supply the name. $stop";
    return;
  fi

  local component=$1
  local classification=component

  dark_crystal_create_folder "$component";
  dark_crystal_generate_package_files $classification;
  dark_crystal_generate_gruntfile $classification;
  dark_crystal_install_component_dependencies;
  dark_crystal_generate_html $classification "$component";

  echo
  echo "$green Done. $stop";
  echo
  echo "$olive New component created at $green$(pwd)$stop";
  echo
}
