'use strict'

gulp    = require 'gulp'
build   = require './build.coffee'
bowerrc = build.bowerrc

# inject bower components
gulp.task 'wiredep', ->
  wiredep = require('wiredep').stream

  gulp.src 'src/{app,components}/*.scss'
    .pipe wiredep(
      directory: bowerrc.directory
    )
    .pipe gulp.dest('src')

  gulp.src 'src/index.html'
    .pipe wiredep(
      directory: bowerrc.directory
    )
    .pipe gulp.dest('src')
