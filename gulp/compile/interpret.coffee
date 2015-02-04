'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
$       = build.$


gulp.task 'compile.interpret.all', ['compile.interpret.coffee','compile.interpret.scss']

gulp.task 'compile.interpret.coffee', ->
  gulp.src "#{GLOBAL.config.src}/**/*.coffee"
    .pipe build.replaceConfigs()
    .pipe $.coffee(bare: true)
      .on 'error', build.handleError
    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()

gulp.task 'compile.interpret.scss', ->
  gulp.src "#{GLOBAL.config.src}/**/*.scss"
    .pipe build.replaceConfigs()
    .pipe $.sass(style: 'expanded')
      .on 'error', build.handleError
    .pipe $.autoprefixer('last 1 version')
    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()
