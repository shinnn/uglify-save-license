# uglify-save-license

[![NPM version](https://badge.fury.io/js/uglify-save-license.png)](http://badge.fury.io/js/uglify-save-license)
[![Build Status](https://travis-ci.org/shinnn/uglify-save-license.png?branch=master)](https://travis-ci.org/shinnn/uglify-save-license)
[![devDependency Status](https://david-dm.org/shinnn/uglify-save-license/dev-status.png)](https://david-dm.org/shinnn/uglify-save-license#info=devDependencies)

Tiny license detector module for UglifyJS's `comments` option

## Concepts

Coming soon.

## Installation

Install latest stable [Node](http://nodejs.org/) and run this command in your project's root directory:

```
npm install --save-dev uglify-save-license
```

## Usage

### Use with [UglifyJS](https://github.com/mishoo/UglifyJS2)

Coming soon.

### Use with [grunt-contrib-uglify](https://github.com/gruntjs/grunt-contrib-uglify)

Coming soon.

## How does it works

Coming soon.

## Example

### CLI tool example

Coming soon.

### [Gruntfile](http://gruntjs.com/getting-started#the-gruntfile) example

```coffeescript
module.exports = (grunt) ->
  'use strict'

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  
  saveLicense = require 'uglify-save-license'

  grunt.initConfig
    uglify:
      target:
        options:
          preserveComments: saveLicense
        files: [
          expand: true
          flatten: true
          cwd: 'path/to/src'
          src: ["**/*.js"]
          dest: 'tmp/'
        ]

    concat:
      script:
        src: ['tmp/*.js']
        dest: 'path/to/build/app.js'

    clean:
      tmpfiles: ['tmp']

  grunt.registerTask 'default' [
    'uglify'
    'concat'
    'clean'
  ]
```

## License

Copyright (c) 2013 [Shinnosuke Watanabe](https://github.com/shinnn) All rights reserved.

Licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).