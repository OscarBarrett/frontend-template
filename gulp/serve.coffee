'use strict'

gulp        = require 'gulp'
browserSync = require 'browser-sync'
middleware  = require './run/proxy'
config      = require '../config.json'

browserSyncInit = (baseDir, files, browser) ->
  if !browser? then browser = 'default'

  browserSync.instance = browserSync.init(files,
    startPath: '/index.html'
    server:
      baseDir: baseDir
      middleware: middleware
      routes:
        '/vendor/bower_components': 'vendor/bower_components'
    browser: browser
  )

gulp.task 'serve', ['compile.move.all', 'compile.interpret.all', 'compile.inject.all', 'watch'], ->
  browserSyncInit([
    config.tmp
  ], [
    "#{config.tmp}/**/*"
  ])

gulp.task 'watch', ['compile.move.all', 'compile.interpret.all', 'compile.inject.all'], ->
  gulp.watch 'app/index.html',                   ['compile.move.all', 'compile.interpret.all', 'compile.inject.all']
  gulp.watch 'app/{app,components}/**/*.scss',   ['compile.move.all', 'compile.interpret.all', 'compile.inject.all']
  gulp.watch 'app/{app,components}/**/*.coffee', ['compile.move.all', 'compile.interpret.all', 'compile.inject.all']
  gulp.watch 'bower.json',                       ['compile.move.all', 'compile.interpret.all', 'compile.inject.all']
