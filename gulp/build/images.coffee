'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config
$       = build.$

### Images ###
gulp.task 'images', ->
  gulp.src "#{config.src}/assets/images/*"
    .pipe $.cache($.imagemin                  # Minify images. Note: this is cached!
      optimizationLevel: 3                    #   If you move directories, you may need to clear the cache (`gulp init`)
      progressive: true
      interlaced: true
    )
    .pipe gulp.dest("#{config.dest}/assets/images") # Save to final destination
    .pipe $.size()
