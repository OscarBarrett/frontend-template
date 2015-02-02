'use strict'

gulp    = require 'gulp'
build   = require './build.coffee'
bowerrc = build.bowerrc
config  = build.config

# inject bower components
gulp.task 'wiredep', ['states'], ->
  wiredep = require('wiredep').stream

  gulp.src 'src/{app,components}/*.scss'
    .pipe wiredep(
      directory: bowerrc.directory
    )
    .pipe gulp.dest('src')

  gulp.src "#{config.tmp}/index.html"
    .pipe wiredep(
      directory: bowerrc.directory
    )
    .pipe gulp.dest(config.tmp)
