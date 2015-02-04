'use strict'

gulp        = require 'gulp'
runSequence = require('run-sequence').use(gulp)
browserSync = require 'browser-sync'
middleware  = require './run/proxy'

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

gulp.task 'serve', ->
  GLOBAL.setBuildEnv 'development'
  runSequence 'clean', 'compile.all', 'run', 'watch'

gulp.task 'watch', ->
  gulp.watch 'app/**/*.*', ['compile.move.all', 'compile.interpret.all', 'compile.inject.all']
  gulp.watch 'bower.json', ['compile.move.all', 'compile.interpret.all', 'compile.inject.all']

gulp.task 'run', ->
  browserSyncInit [
    GLOBAL.config.tmp
  ], [
    "#{GLOBAL.config.tmp}/**/*"
  ]
