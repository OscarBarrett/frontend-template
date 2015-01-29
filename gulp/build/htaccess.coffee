'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config

### htaccess ###
gulp.task 'htaccess', ->
  gulp.src "#{config.src}/**/.htaccess"
    .pipe gulp.dest(config.dest)
