'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
bowerrc = build.bowerrc
$       = build.$

gulp.task 'compile.inject.all', ['compile.inject.bower', 'compile.inject.partialcss', 'compile.inject.lib', 'compile.inject.partialjs']

gulp.task 'compile.inject.bower', ['compile.move.all'], ->
  wiredep = require('wiredep').stream

  gulp.src "#{GLOBAL.config.tmp}/index.html"
    .pipe wiredep(
      directory: bowerrc.directory
    )
    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()


gulp.task 'compile.inject.partialcss', ['compile.inject.bower', 'compile.interpret.scss'], ->

  gulp.src "#{GLOBAL.config.tmp}/index.html"
    .pipe $.inject(
      gulp.src("#{GLOBAL.config.tmp}/{states,components}/**/*.css", read: false, relative: true),
      {
        starttag: '<!-- inject:partialcss -->'
        ignorePath: GLOBAL.config.tmp
      }
    )
    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()

gulp.task 'compile.inject.partialjs', ['compile.inject.partialcss', 'compile.interpret.coffee'], ->

  # Inject any component or state js into index
  gulp.src "#{GLOBAL.config.tmp}/index.html"
    .pipe $.inject(
      gulp.src("#{GLOBAL.config.tmp}/{states,components}/**/*.js", read: false, relative: true),
      {
        starttag: '<!-- inject:partialjs -->'
        ignorePath: GLOBAL.config.tmp
      }
    )
    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()

gulp.task 'compile.inject.lib', ['compile.interpret.coffee'], ->

  # Inject lib js into index
  gulp.src "#{GLOBAL.config.tmp}/index.html"
    .pipe $.inject(
      gulp.src("#{GLOBAL.config.tmp}/lib/**/*.js", read: false, relative: true),
      {
        starttag: '<!-- inject:lib -->'
        ignorePath: GLOBAL.config.tmp
      }
    )
    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()
