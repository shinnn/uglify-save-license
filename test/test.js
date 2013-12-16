'use strict';

var path = require('path');
var grunt = require('grunt');

var files = grunt.file.expandMapping(
  '{,*/}*.js',
  'test/expected',
  { cwd: 'test/actual' }
);

function exportTests(map) {
  var basename = path.basename(map.src);
  
  var actual = grunt.file.read(map.src);
  var expected = grunt.file.read(map.dest);

  exports[basename] = function(test) {
    test.strictEqual(
      actual,
      expected,
      basename + " is not uglified to the expected output."
    );
    test.done();
  };
}

files.forEach(exportTests);
