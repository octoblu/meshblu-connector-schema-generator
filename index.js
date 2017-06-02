var pathExists = require('path-exists')
var theFile

if (pathExists.sync('./dist/index.js')) {
  theFile = require('./dist')
} else {
  require('coffee-script/register');
  require('fs-cson/register')
  theFile = require('./src')
}

module.exports = theFile;
