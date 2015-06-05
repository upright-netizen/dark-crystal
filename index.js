#!/usr/bin/env node

/*jshint node: true, laxcomma: true, eqeqeq: true, bitwise: true, curly: true, latedef: true, strict: true, plusplus: true*/
/*global require */


'use strict';

var minimist = require('minimist');
var RainbowBarf = require('rainbow-barf');
var superenv = require('superenv');

var darkHomeDir = process.env.HOME + '/.darkcrystal';
var argv = minimist(process.argv.slice(2));
var log = new RainbowBarf();

//
//  Dark Crystal
//

/**
 *
 *    TODO:
 *
 *    - Read a config file using superenv and maybe path-extra
 *    - Do a bunch of file work to build a project
 *
 */


//  Stubs and Templates
// installDir=/usr/local;
// rootDir=${installDir}/dark-crystal;

// export resources=${rootDir}/resources;
// lib=${rootDir}/lib;

//
//  import color logger
//
// . "$lib/color_logger.sh";



// function dark_crystal_usage () {

//   test "$devMode" = true && {
//     log
//     log "     [dev mode]                                                        " -k "red" -c "black";
//   }

//   log;
//   log "  " -n;
//   log "usage: " -n -c "purple";
//   log "dark" -bn -c "purple";
//   log " [command] [args]" -c "purple";
//   log

// cat <<USAGE
//   Commands

//   ====================================================================

//     component <name>              Create a new polymer web component
//     prototype <name>              Create a new html prototype
//     update                        Update dark crystal
//     uninstall                     Uninstall dark-crystal

// USAGE
// }

//
//  Import the libs
//

// . "$lib/common.sh";
// . "$lib/component_functions.sh";
// . "$lib/prototype_functions.sh";
// . "$lib/utils.sh";


//
//  Init
//


var command = argv._[0];

//  test -z "$1" && {
//   dark_crystal_usage;
//   exit 1;
//  }

if (!command) {
  // usage;
  log('USAGE: todo: write usage', ['c:red', 'u']);
  return;
}

var env = superenv('darkcrystal');

// env.projects.forEach(function eachProject (project) {
//   console.log(project.title);
// });



// sample running a command
// var exec = require('child_process').exec;
// var child = exec('ls -al', function (err, stdout, stderr) {
//   console.log(stdout);
// });


// use commander

//   test "$1" = "component" && shift && dark_crystal_new_component "$@";
//   test "$1" = "prototype" && shift && dark_crystal_new_prototype "$@";
//   test "$1" = "update" && shift && dark_crystal_update "$@";
//   test "$1" = 'uninstall' && shift && dark_crystal_uninstall;
//    dev options
//   test "$1" = 'link' && shift && dark_crystal_link "$@";