'use strict'

gulp    = require 'gulp'
build   = require './build.coffee'
$       = build.$

del     = require 'del'

### Clean ###
gulp.task 'clean', ['clear_cache'], (cwd) ->
  # Delete the temporary and destination directories
  del [
    GLOBAL.config.tmp
    GLOBAL.config.dest
  ], cwd


### Clear Cache ###
gulp.task 'clear_cache', (cwd) ->
  $.cache.clearAll cwd
