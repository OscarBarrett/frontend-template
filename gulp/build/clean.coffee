'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config
$       = build.$

del     = require 'del'

### Clean ###
gulp.task 'clean', (cwd) ->
  # Delete the temporary and destination directories
  del [
    config.tmp
    config.dest
  ], cwd


### Clear Cache ###
gulp.task 'clear_cache', (cwd) ->
  $.cache.clearAll cwd
