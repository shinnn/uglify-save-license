// uglify-save-license.js v0.0.3
// Copyright (c) 2013 Shinnosuke Watanabe
// Licensed uder the MIT license

'use strict';

// regexp to determine whether the comment looks like license text.
var licenseRegexp = /^\!|^@preserve|^@cc_on|\bMIT\b|\bMPL\b|\bGPL\b|\(c\)|License|Copyright/mi;

// number of line where license comment appeared last
var _prevCommentLine = 0;

module.exports = function saveLicense(node, comment) {

  // check if the comment contains license text
  if (licenseRegexp.test(comment.value) ||
      comment.line === 1 ||
      comment.line === _prevCommentLine + 1) {

    // if the comment contains license, save line number
    _prevCommentLine = comment.line;

    return true;
  }

  // if the comment doesn't contain license, reset line number
  _prevCommentLine = 0;

  return false;
};
