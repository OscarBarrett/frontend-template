'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config
$       = build.$

compile_styles = (dest) ->
    gulp.src "#{config.src}/{app,components}/**/*.scss"
    .pipe $.sass(style: 'expanded')           # Compile sass to css
      .on 'error', build.handleError
    .pipe $.autoprefixer('last 1 version')    # Add vendor prefixes to css rules
    .pipe gulp.dest(dest)               # Save temporarily
    .pipe $.size()

### Styles ###
gulp.task 'styles', ->
  compile_styles config.tmp

gulp.task 'styles_staging', ->
  compile_styles config.dest
