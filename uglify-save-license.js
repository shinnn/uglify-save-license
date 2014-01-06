// uglify-save-license.js v0.2.1
// Copyright (c) 2013 - 2014 Shinnosuke Watanabe
// Licensed uder the MIT license

'use strict';

// regexp to determine whether the comment looks like license text.
var licenseRegexp = /^\!|^@preserve|^@cc_on|\bMIT\b|\bMPL\b|\bGPL\b|\bBSD\b|\(c\)|License|Copyright/mi;

// number of line where license comment appeared last
var prevCommentLine = 0;
// name of the file minified last
var prevFile = '';

module.exports = function saveLicense(node, comment) {
  if (comment.file !== prevFile) {
    prevCommentLine = 0;
  }

  // check if the comment contains license text
  var result = licenseRegexp.test(comment.value) ||
               comment.line === 1 ||
               comment.line === prevCommentLine + 1;
  
  if (result) {
    // if the comment contains license, save line number
    prevCommentLine = comment.line;
  } else {
    // if the comment doesn't contain license, reset line number
    prevCommentLine = 0;
  }
  
  // save current filename
  prevFile = comment.file;
  
  return result;
};
