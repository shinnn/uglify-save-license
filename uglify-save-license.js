// uglify-save-license.js v0.1.0
// Copyright (c) 2013 Shinnosuke Watanabe
// Licensed uder the MIT license

'use strict';

// regexp to determine whether the comment looks like license text.
var licenseRegexp = /^\!|^@preserve|^@cc_on|\bMIT\b|\bMPL\b|\bGPL\b|\(c\)|License|Copyright/mi;

// number of line where license comment appeared last
var prevCommentLine = 0;
var prevFile = '';

module.exports = function saveLicense(node, comment) {
  var result = false;

  if(comment.file !== prevFile) {
    prevCommentLine = 0;
  }

  // check if the comment contains license text
  if (licenseRegexp.test(comment.value) ||
      comment.line === 1 ||
      comment.line === prevCommentLine + 1) {
    result = true;
  }
  
  if (result) {
    // if the comment contains license, save line number
    prevCommentLine = comment.line;    
  } else {
    // if the comment doesn't contain license, reset line number
    prevCommentLine = 0;
  }

  prevFile = comment.file;

  return result;
};
