module.exports = (grunt) ->
  'use strict'

  require('load-grunt-tasks')(grunt)
  
  grunt.initConfig
    jshint:
      options:
        strict: true
        node: true
        indent: 2
        unused: true
      main:
        files:
          src: ['uglify-save-license.js']
    
    watch:
      main:
        files: ['uglify-save-license.js']
        tasks: ['jshint']
    
    release:
      options: {}

  defaultTasks = [
    'jshint'
    'watch'
  ]
  
  grunt.task.registerTask 'default', defaultTasks

  grunt.task.registerTask 'publish', ['jshint', 'release:patch']
  