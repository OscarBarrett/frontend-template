'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
$       = build.$
cached = require('gulp-cached')

gulp.task 'compile.move.all', ['compile.move.files']

gulp.task 'compile.move.files', ->
  gulp.src "#{GLOBAL.config.src}/**/*.{css,js,html}"
    .pipe cached('compile.move.files-compilable')
    .pipe build.replaceConfigs()
    .pipe build.injectFiles()
    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()

  gulp.src "#{GLOBAL.config.src}/**/*.{#{GLOBAL.config.binary_types},#{GLOBAL.config.font_types}}"
    .pipe cached('compile.move.files-binary')
    .pipe gulp.dest("#{GLOBAL.config.tmp}/#{GLOBAL.config.assetpath}")
    .pipe $.size()
