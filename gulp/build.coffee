'use strict'

gulp        = require 'gulp'
fs          = require 'fs'
runSequence = require('run-sequence').use(gulp)
lazypipe    = require('lazypipe')

### Exports ###
handleError = exports.handleError = (err) ->
  console.error err.toString()
  @emit 'end'
  return

# Load all gulp plugins. Accessed in nested tasks by running: $ = (require '../build.coffee').$
$ = exports.$ = require('gulp-load-plugins')(
  pattern: ['gulp-*']
)


bowerrc = exports.bowerrc = JSON.parse fs.readFileSync('.bowerrc', 'utf8')

replaceConfigs = exports.replaceConfigs = lazypipe()
  .pipe $.replace, /\$\$replace:(.+)\$\$/g, (match,configName,offset,string) ->
    GLOBAL.config[configName]

require('require-dir')('./compile')
require('require-dir')('./compress')
require('require-dir')('./publish')

### Tasks ###
gulp.task 'build', ->
  runSequence 'clean', 'compile.all', 'compress.all', 'publish.production'

gulp.task 'build-staging', ->
  GLOBAL.setBuildEnv 'staging'
  runSequence 'clean', 'compile.all', 'publish.staging'

gulp.task 'init', ['clean', 'clear_cache']
