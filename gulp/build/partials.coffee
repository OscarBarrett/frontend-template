'use strict'

gulp    = require 'gulp'
config  = require '../../config.json'

$ = require('gulp-load-plugins')(
  pattern: ['gulp-*']
)

### Partials ###
gulp.task 'partials', ->
  gulp.src "#{config.src}/{app,components}/**/*.html"
    .pipe $.minifyHtml(           # Minify
      empty: true
      spare: true
      quotes: true
    )
    .pipe $.ngHtml2js(            # Convert partials to js, storing them in $templateCache
      moduleName: config.app_name
    )
    .pipe gulp.dest(config.tmp)
    .pipe $.size()


### Partials for staging (no minification/$templateCache conversion) ###
gulp.task 'partials_staging', ->
  gulp.src "#{config.src}/{app,components}/**/*.html"
    .pipe gulp.dest(config.dest)
    .pipe $.size()
