module.exports = (grunt) ->
  'use strict'

  require('load-grunt-tasks')(grunt)
  semver = require 'semver'
  
  pkg = grunt.file.readJSON 'package.json'
  
  getNextVersion = ->
    currentVer = pkg.version
    semver.inc currentVer, 'patch'
      
  grunt.initConfig
    jshint:
      options:
        camelcase: true
        trailing: true
        indent: 2
        browser: false
        node: true
      main:
        files:
          src: ['uglify-save-license.js']
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
        files:
          'uglify-save-license.js': ['uglify-save-license.js']
      year:
        options:
          prefix: '2013 - '
          excludePrefix: true
          patterns: [
            match: "#{ new Date().getFullYear() - 1 }"
            replacement: "#{ new Date().getFullYear() }"
          ]
        files:
          'uglify-save-license.js': ['uglify-save-license.js']
    
    uglify:
      options:
        preserveComments: ->
          args = grunt.util.toArray arguments
          require('./uglify-save-license.js') args...
      fixture:
        files: [
          expand: true
          cwd: 'test/fixtures'
          src: '{,*/}*.js'
          dest: 'test/actual'
        ]
    
    nodeunit:
      all: ['test/test.js']

    watch:
      main:
        files: ['uglify-save-license.js']
        tasks: ['build']
    
    release:
      options: {}

  grunt.registerTask 'test', [
    'jshint'
    'clean'
    'uglify'
    'nodeunit'
  ]

  grunt.registerTask 'build', ['replace', 'test']
  
  grunt.registerTask 'default', ['build', 'watch']

  grunt.registerTask 'publish', ['build', 'release:patch']
