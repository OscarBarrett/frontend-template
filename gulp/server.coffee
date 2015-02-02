'use strict'

gulp        = require 'gulp'
browserSync = require 'browser-sync'
middleware  = require './proxy'
config      = require '../config.json'

browserSyncInit = (baseDir, files, browser) ->
  if !browser? then browser = 'default'

  browserSync.instance = browserSync.init(files,
    startPath: '/index.html'
    server:
      baseDir: baseDir
      middleware: middleware
      routes:
        '/bower_components': 'bower_components'
    browser: browser
  )

gulp.task 'serve', ['states', 'scripts', 'watch'], ->
  browserSyncInit([
    '.tmp'
    'src'
  ], [
    '.tmp/index.html'
    '.tmp/{app,components}/**/*.css'
    'src/assets/images/**/*'
    'src/{app,components}/**/*.html'
    'src/{app,components}/**/*.js'
  ])

gulp.task 'serve:dist', ['build'], ->
  browserSyncInit config.dest

gulp.task 'serve:e2e', ->
  browserSyncInit ['src', '.tmp'], null, []

gulp.task 'serve:e2e-dist', ['watch'], ->
  browserSyncInit config.dest, null, []
