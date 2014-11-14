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

gulp.task('default', ['less', 'watch', 'webserver']);

// Production build tasks
gulp.task('config-production', function () {
  gulp.src('{Procfile,package.json}')
  .pipe(gulp.dest('dist'));
});

gulp.task('html-production', function(){
    gulp.src('*.html')
    .pipe(gulp.dest('dist'));
});

gulp.task('js-production', function(){
    gulp.src('app/**/*.*', { base: './' })
    .pipe(gulp.dest('dist'));

    gulp.src('bower_components/**/*.*', { base: './' })
    .pipe(gulp.dest('dist'));
});

gulp.task('less-production', function(){
    gulp.src('less/*.less')
    .pipe(less())
    .pipe(gulp.dest('dist/css'));
});

gulp.task('production', ['less-production', 'html-production', 'js-production', 'config-production']);

