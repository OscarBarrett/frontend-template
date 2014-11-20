'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config
$       = build.$

mainBowerFiles = require 'main-bower-files'

### Fonts ###
gulp.task 'fonts', ->
  gulp.src mainBowerFiles()
    .pipe $.filter('**/*.{eot,svg,ttf,woff}')
    .pipe $.flatten()                         # Move all fonts into a single dir
    .pipe gulp.dest("#{config.dest}/fonts")   # Save to final destination
    .pipe $.size()
