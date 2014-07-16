

#                ooooooooo.                          .                 .
#                `888   `Y88.                      .o8               .o8
#                 888   .d88' oooo d8b  .ooooo.  .o888oo  .ooooo.  .o888oo oooo    ooo oo.ooooo.   .ooooo.
#                 888ooo88P'  `888""8P d88' `88b   888   d88' `88b   888    `88.  .8'   888' `88b d88' `88b
#                 888          888     888   888   888   888   888   888     `88..8'    888   888 888ooo888
#                 888          888     888   888   888 . 888   888   888 .    `888'     888   888 888    .o
#                o888o        d888b    `Y8bod8P'   "888" `Y8bod8P'   "888"     .8'      888bod8P' `Y8bod8P'
#                                                                          .o..P'       888
#                                                                          `Y8P'       o888o


function dark_crystal_install_prototype_dependencies {
  #
  # npm install
  #

  echo
  echo "$green NPM install $stop";
  echo

  # make a node_modules folder locally so they don't get installed somewhere else on the path
  test -d node_modules || mkdir -p node_modules;

  # install grunt contrib plugins
  npm install --save-dev grunt-contrib-connect;
}

function dark_crystal_generate_prototype_html {
  local name=$1

  echo
  echo "$green Generating index.html $stop";
  echo

  sed -e \
    "s;%PROTOTYPE%;$name;g" \
  "$resources/prototype-index.html.template" > "index.html"
}


function dark_crystal_new_prototype {
  # ensure we have a name
  if [ -z "$1" ]; then
    echo "$yellow Please supply the name. $stop";
    return;
  fi

  local name=$1
  local classification=prototype

  dark_crystal_create_folder "$name";
  dark_crystal_generate_package_files $classification;
  dark_crystal_generate_gruntfile $classification;
  dark_crystal_install_prototype_dependencies;
  dark_crystal_generate_html $classification "$name";

  echo
  echo "$green Done. $stop";
  echo
  echo "$olive New component created at $green$(pwd)$stop";
  echo
}

