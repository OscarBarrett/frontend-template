'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config
$       = build.$

compile_scripts = (dest) ->
  gulp.src "#{config.src}/{app,components}/**/*.coffee"
    .pipe $.coffee(bare: true)                # Compile coffeescript to js
      .on 'error', build.handleError
    .pipe gulp.dest(dest)
    .pipe $.size()

### Scripts ###
gulp.task 'scripts', ->
  compile_scripts(config.tmp)

gulp.task 'scripts_staging', ->
  compile_scripts(config.dest)