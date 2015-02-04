'use strict'

gulp           = require 'gulp'
build          = require '../build.coffee'
mainBowerFiles = require 'main-bower-files'
bowerrc        = build.bowerrc
config         = build.config
$              = build.$

gulp.task 'publish.staging',    ['publish.bower', 'publish.files', 'publish.htaccess']
gulp.task 'publish.production', ['publish.bowerfonts', 'publish.assets', 'publish.basefiles', 'publish.htaccess']

gulp.task 'publish.bower', ->
  gulp.src "#{bowerrc.directory}/**/*"
    .pipe gulp.dest("#{config.dest}/vendor/bower_components")
    .pipe $.size()

gulp.task 'publish.files', ->
  gulp.src "#{config.tmp}/**/*"
    .pipe gulp.dest(config.dest)
    .pipe $.size()

gulp.task 'publish.bowerfonts', ->
  gulp.src mainBowerFiles()
    .pipe $.filter('**/*.{eot,svg,ttf,woff}')
    .pipe $.flatten()                                # Move all fonts into a single dir
    .pipe gulp.dest("#{config.dest}/assets/fonts")   # Save to final destination
    .pipe $.size()

gulp.task 'publish.assets', ->
  gulp.src "#{config.tmp}/assets/**/*"
    .pipe gulp.dest("#{config.dest}/assets")
    .pipe $.size()

gulp.task 'publish.basefiles', ->
  gulp.src "#{config.tmp}/*.*"
    .pipe gulp.dest(config.dest)
    .pipe $.size()

gulp.task 'publish.htaccess', ->
  gulp.src "#{config.src}/**/.htaccess"
    .pipe gulp.dest(config.dest)
    .pipe $.size()
