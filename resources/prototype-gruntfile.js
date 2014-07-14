/*global module:false*/
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    connect: {
      spec: {
        options: {
          port: 5555
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-connect');

  // Default task.
  grunt.registerTask('default', 'connect');
};
