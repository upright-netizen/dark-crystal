#!/usr/bin/env zsh

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
  log
  log "Collecting information for config files" -c "green";
  log

  #
  # Default Values
  #
  classification=$1
  defaultName=$(basename "$PWD");
  defaultVersion="0.0.0";
  defaultDescription="<description here>";
  defaultAuthor=$(git config --global user.name);

  read "name?Name: ($defaultName) ";
  name=${name:-$defaultName};

  read "version?Version: ($defaultVersion) ";
  version=${version:-$defaultVersion};

  read "description?Description: ";
  description=${description:-$defaultDescription};

  read "author?Author: ($defaultAuthor) ";
  author=${author:-$defaultAuthor};

  dark_crystal_generate_package_json "$name" "$version" "$description" "$author";
  dark_crystal_generate_bower_json "$name" "$version" "$description" "$author";
}

function dark_crystal_create_folder {
  folder=$1

  if test -d "$folder"; then
    log "$folder exists. Exiting" -c "red";
    exit 1;
  fi

  # make directory for new thing
  mkdir "$folder";

  # cd to directory
  cd "$folder";

  unset folder
}

function dark_crystal_generate_gruntfile {
  log
  log "Making Gruntfile" -c "green";
  log

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
