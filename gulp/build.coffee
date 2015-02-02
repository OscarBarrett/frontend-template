'use strict'

gulp = require 'gulp'
fs = require 'fs'

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

exports.bowerrc = fs.readFileSync '.bowerrc', 'utf8'

require('require-dir')('./build') # Load build tasks

### Tasks ###
gulp.task 'build', ['clean'], ->
  gulp.start 'html', 'default_tasks'

gulp.task 'build-staging', ['clean'], ->
  gulp.start 'html_staging', 'default_tasks'

gulp.task 'default_tasks', ->
  gulp.start 'images', 'fonts', 'htaccess', 'states'

gulp.task 'init', ['clean', 'clear_cache']
