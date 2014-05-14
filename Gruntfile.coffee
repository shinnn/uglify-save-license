module.exports = (grunt) ->
  'use strict'

  require('load-grunt-tasks') grunt
  semver = require 'semver'
  
  pkg = grunt.file.readJSON 'package.json'
  MAIN = pkg.main
  
  getNextVersion = ->
    currentVer = pkg.version
    semver.inc currentVer, 'patch'
      
  grunt.initConfig
    jshint:
      options:
        jshintrc: '.jshintrc'
      main:
        files:
          src: [MAIN]
      test:
        files:
          src: '<%= nodeunit.all %>'
    
    clean:
      test:
        src: ['test/actual/*.js']
    
    replace:
      version:
        options:
          prefix: ' v'
          preservePrefix: true
          patterns: [
            match: pkg.version
            replacement: getNextVersion()
          ]
        src: [MAIN]
        dest: MAIN
      year:
        options:
          prefix: '2013 - '
          preservePrefix: true
          patterns: [
            match: "#{ new Date().getFullYear() - 1 }"
            replacement: "#{ new Date().getFullYear() }"
          ]
        src: [MAIN]
        dest: MAIN
    
    uglify:
      options:
        preserveComments: ->
          require(MAIN) arguments...
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
        files: [MAIN]
        tasks: ['build']
    
    release: {}

  grunt.registerTask 'test', [
    'jshint'
    'clean'
    'uglify'
    'nodeunit'
  ]

  grunt.registerTask 'build', ['replace', 'test']
  grunt.registerTask 'default', ['build', 'watch']
  grunt.registerTask 'publish', ['build', 'release:patch']
