'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
bowerrc = build.bowerrc
config  = build.config
$       = build.$

gulp.task 'compile.inject.all', ['compile.inject.bower','compile.inject.statecss']

gulp.task 'compile.inject.bower', ['compile.move.all'], ->
  wiredep = require('wiredep').stream

  gulp.src "#{config.tmp}/index.html"
    .pipe wiredep(
      directory: bowerrc.directory
    )
    .pipe gulp.dest(config.tmp)
    .pipe $.size()


gulp.task 'compile.inject.statecss', ['compile.move.all', 'compile.inject.bower'], ->

  gulp.src "#{config.tmp}/index.html"
    .pipe $.inject(
      gulp.src("#{config.tmp}/states/**/*.css", read: false, relative: true),
      {
        starttag: '<!-- inject:statecss -->'
        ignorePath: config.tmp
      }
    )
    .pipe gulp.dest(config.tmp)
    .pipe $.size()
