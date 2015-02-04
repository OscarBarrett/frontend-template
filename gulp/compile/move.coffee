'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config
$       = build.$

gulp.task 'compile.move.all', ['compile.move.files']

gulp.task 'compile.move.files', ->
  gulp.src "#{config.src}/**/*.{css,js,jpg,png,gif,html,ico}"
    .pipe gulp.dest(config.tmp)
    .pipe $.size()
