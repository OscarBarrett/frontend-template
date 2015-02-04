'use strict'

gulp        = require 'gulp'
fs          = require 'fs'
runSequence = require('run-sequence').use(gulp)

### Exports ###
exports.handleError = (err) ->
  console.error err.toString()
  @emit 'end'
  return

exports.config = require '../config.json'

# Load all gulp plugins. Accessed in nested tasks by running: $ = (require '../build.coffee').$
exports.$ = require('gulp-load-plugins')(
  pattern: ['gulp-*']
)

exports.bowerrc = JSON.parse fs.readFileSync('.bowerrc', 'utf8')

require('require-dir')('./compile')
require('require-dir')('./compress')
require('require-dir')('./publish')

### Tasks ###
gulp.task 'build', ->
  runSequence 'clean', 'compile.all', 'compress.all', 'publish.production'

gulp.task 'build-staging', ->
  runSequence 'clean', 'compile.all', 'publish.staging'

gulp.task 'init', ['clean', 'clear_cache']
