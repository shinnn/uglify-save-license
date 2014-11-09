module.exports = (grunt) ->
  'use strict'

  require('jit-grunt') grunt

  grunt.initConfig
    jshint:
      options:
        jshintrc: '.jshintrc'
      main: ['index.js']
      test: '<%= nodeunit.all %>'

    clean:
      test: ['test/actual/*.js']

    uglify:
      options:
        preserveComments: ->
          require('./') arguments...
      fixture:
        files: [
          expand: true
          cwd: 'test/fixtures'
          src: '{,*/}*.js'
          dest: 'test/actual'
        ]

    nodeunit:
      options:
        reporter: 'default'
      all: ['test/test.js']

    watch:
      main:
        files: ['index.js']
        tasks: ['build']

  grunt.registerTask 'test', [
    'jshint'
    'clean'
    'uglify'
    'nodeunit'
  ]

  grunt.registerTask 'default', ['test', 'watch']
