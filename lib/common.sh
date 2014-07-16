function dark_crystal_generate_package_json {

  local name=$1
  local version=$2
  local description=$3
  local author=$4

#
# Generate package.json
#

sed -e \
  "s;%NAME%;$name;g" -e \
  "s;%VERSION%;$version;g" -e \
  "s;%DESCRIPTION%;$description;g" -e \
  "s;%AUTHOR%;$author;g" \
$resources/package.json.template > package.json

}

function dark_crystal_generate_bower_json {
  local name=$1
  local version=$2
  local description=$3
  local author=$4

  #
  # Generate bower.json
  #

  sed -e \
    "s;%NAME%;$name;g" -e \
    "s;%VERSION%;$version;g" -e \
    "s;%DESCRIPTION%;$description;g" -e \
    "s;%AUTHOR%;$author;g" \
  $resources/bower.json.template > bower.json
}

function dark_crystal_generate_package_files {
  echo
  echo "$green Collecting information for config files $stop";
  echo

  #
  # Default Values
  #
  classification=$1
  defaultName=$(basename "$PWD");
  defaultVersion="0.0.0";
  defaultDescription="<description here>";
  defaultAuthor=$(git config --global user.name);

  read -p "Name: ($defaultName) " name;
  name=${name:-$defaultName};

  read -p "Version: ($defaultVersion) " version;
  version=${version:-$defaultVersion};

  read -p "Description: " description;
  description=${description:-$defaultDescription};

  read -p "Author: ($defaultAuthor) " author
  author=${author:-$defaultAuthor};

  dark_crystal_generate_package_json "$name" "$version" "$description" "$author";
  dark_crystal_generate_bower_json "$name" "$version" "$description" "$author";
}

function dark_crystal_create_folder {
  folder=$1

  if test -d "$folder"; then
    echo "$red$folder exists. Exiting";
    exit 1;
  fi

  # make directory for new thing
  mkdir "$folder";

  # cd to directory
  cd "$folder";

  unset folder
}

function dark_crystal_generate_gruntfile {
  echo
  echo "$green Making Gruntfile $stop";
  echo

  local classification=$1

  cat "$resources/$classification-gruntfile.js" > Gruntfile.js;
}



function dark_crystal_generate_html {
  local classification=$1
  local name=$2

  test "$classification" = "component" && {
    dark_crystal_generate_component_html "$name";
  }

  test "$classification" = "prototype" && {
    dark_crystal_generate_prototype_html "$name";
  }
}
