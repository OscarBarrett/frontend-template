'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config
$       = build.$


gulp.task 'compile.interpret.all', ['compile.interpret.coffee','compile.interpret.scss']

gulp.task 'compile.interpret.coffee', ->
  gulp.src "#{config.src}/**/*.coffee"
    .pipe $.coffee(bare: true)
      .on 'error', build.handleError
    .pipe gulp.dest(config.tmp)
    .pipe $.size()

gulp.task 'compile.interpret.scss', ->
  gulp.src "#{config.src}/**/*.scss"
    .pipe $.sass(style: 'expanded')
      .on 'error', build.handleError
    .pipe $.autoprefixer('last 1 version')
    .pipe gulp.dest(config.tmp)
    .pipe $.size()
