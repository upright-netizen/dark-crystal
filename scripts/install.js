#!/usr/bin/env node
/*global require */

'use strict';

var path = require('path');
var fs = require('fs');
var RainbowBarf = require('rainbow-barf');
var Q = require('q');

var log = new RainbowBarf();

var rcPath = path.join(process.env.HOME, '.darkcrystalrc');
var homeDirPath = path.join(process.env.HOME, '.darkcrystal');

function checkForRcFile () {
  var deferred = Q.defer();

  log('check for rc file (', ['c:bright_green', 'n']);
  log(rcPath, ['c:cyan', 'n']);
  log(') ...', ['c:bright_green']);
  log();

  fs.stat(rcPath, function postStatCheckforRcFile (err, stats) {
    if (err) {
      deferred.reject(err);
    } else {
      deferred.resolve(stats);
    }
  });

  return deferred.promise;
}

function checkForDarkDir () {
  var deferred = Q.defer();

  log('check for dark crystal home directory (', ['c:bright_green', 'n']);
  log(homeDirPath, ['c:cyan', 'n']);
  log(') ...', ['c:bright_green']);

  fs.stat(homeDirPath, function postStatCheckforHomeDir (err, stats) {
    if (err) {
      deferred.reject(err);
    } else {
      deferred.resolve(stats);
    }
  });

  return deferred.promise;
}

// Check for .darkcrystalrc

checkForRcFile().then(function (stats) {
  if (stats.isFile()) {
    log(rcPath, ['c:bright_yellow', 'n']);
    log(' file found, moving on', []);
  }
}).catch(function catchErr (err) {
  if (err && 'ENOENT' === err.code) {
    log(rcPath, ['c:bright_red', 'n']);
    log(' not found', ['c:bright_red']);
    log('Creating ', ['c:bright_green', 'n']);
    log(rcPath, ['c:bright_yellow']);

    fs.writeFile(rcPath, JSON.stringify({}), function rcFileOpenCallback (err) {
      if (err) {
        log('err :' + err, '');
      }
    });

  }
});

// Check for .darkcrystal directory

checkForDarkDir().then(function (stats) {
  if (stats.isDirectory()) {
    log(homeDirPath, ['c:bright_yellow', 'n']);
    log(' found, moving on', []);
  }
}).catch(function createDarkHomeDir (err) {
  if (err && 'ENOENT' === err.code) {
    log(homeDirPath, ['c:bright_red', 'n']);
    log(' not found', ['c:bright_red']);
    log('Creating ', ['n']);
    log(homeDirPath, ['c:bright_yellow']);

    // make a dir here.
  }
});