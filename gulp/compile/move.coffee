'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
$       = build.$

gulp.task 'compile.move.all', ['compile.move.files']

gulp.task 'compile.move.files', ->
  gulp.src "#{GLOBAL.config.src}/**/*.{css,js,html,ico}"
    .pipe build.replaceConfigs()
    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()

  gulp.src "#{GLOBAL.config.src}/**/*.{jpg,png,gif}"
    .pipe gulp.dest("#{GLOBAL.config.tmp}/#{GLOBAL.config.assetpath}")
    .pipe $.size()
