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
    
    release:
      options: {}

  defaultTasks = [
    'replace'
    'jshint'
    'uglify'
    'nodeunit'    
    'watch'
  ]
  
  grunt.task.registerTask 'test', [
    'replace'
    'jshint'
    'uglify'
    'nodeunit'    
  ]
  
  grunt.task.registerTask 'default', defaultTasks

  grunt.task.registerTask 'publish', ->
    grunt.task.run ['test', 'release:patch']
