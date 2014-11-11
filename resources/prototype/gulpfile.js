/*jshint esnext: true, laxcomma: true, eqeqeq: true, bitwise: true, curly: true, latedef: true, strict: true, plusplus: true*/
/*global require: true, console: true */

'use strict';

var gulp = require('gulp');
var less = require('gulp-less');
var webserver = require('gulp-webserver');
var bowerRequireJS = require('bower-requirejs');

gulp.task('less', function(){
    gulp.src('less/*.less')
    .pipe(less())
    .pipe(gulp.dest('css'));
});

gulp.task('watch', function watchTask () {
  gulp.watch(['less/**/*.less'], ['less']);
});

gulp.task('bower', function() {
    var options = {
      baseUrl: 'app',
      config: 'app/config.js',
      transitive: true
    };

    bowerRequireJS(options, function (/* rjsConfigFromBower */) {
        console.log('Updated src/app/require.config.js !');
    });
});

gulp.task('webserver', function() {
  gulp.src('.')
    .pipe(webserver({
      port: 5555
    }));
});

gulp.task('default', ['watch', 'webserver']);
