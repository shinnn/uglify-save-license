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
          src: ['test/test.js']
    
    clean:
      test:
        src: ['test/actual/*.js']
    
    replace:
      main:
        options:
          prefix: 'v'
          patterns: [
            match: pkg.version
            replacement: "v#{ getNextVersion() }"
          ]
        files:
          'uglify-save-license.js': ['uglify-save-license.js']
    
    uglify:
      options:
        preserveComments: ->
          args = Array::slice.call arguments, 0
          require('./uglify-save-license.js') args...
      fixture:
        files: [
          expand: true
          cwd: 'test/fixtures'
          src: '{,*/}*.js'
          dest: 'test/actual'
        ]
    
    nodeunit: ['test/test.js']

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
