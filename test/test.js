'use strict';

var path = require('path');
var grunt = require('grunt');

var files = grunt.file.expandMapping (
  '{,*/,*/*/}*.js',
  'test/expected',
  { cwd: 'test/actual' }
);

function exportTests (map) {
  var basename = path.basename(map.src);
  
  exports[basename] = function (test) {
    var actual = grunt.file.read(map.src);
    var expected = grunt.file.read(map.dest);
    
    test.strictEqual(
      actual,
      expected
    );
    test.done();
  };
}

files.forEach(exportTests);
