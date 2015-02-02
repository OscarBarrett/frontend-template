'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config
$       = build.$

uglifySaveLicense = require 'uglify-save-license'

### HTML compilation ###
gulp.task 'html', ['styles', 'scripts', 'partials'], ->
  # Filters. Allows us to work on a subset of the original files.
  htmlFilter  = $.filter('*.html')
  jsFilter    = $.filter('**/*.js')
  cssFilter   = $.filter('**/*.css')
  assets      = undefined

  gulp.src "#{config.src}/index.html"
    # Inject partials into the template
    .pipe $.inject(
      gulp.src("#{config.tmp}/{app/partials,components}/**/*.js", read: false), {
        starttag: '<!-- inject:partials -->'
        addRootSlash: false
        addPrefix: '../'
      }
    )

    # Assets filter
    .pipe(assets = $.useref.assets())
    .pipe $.rev()                             # Add revision number

    # JS filter
    .pipe jsFilter
    .pipe $.ngAnnotate()                      # Annotate
    .pipe $.uglify(preserveComments: uglifySaveLicense) # Minify, preserving only licenses in comments
    .pipe jsFilter.restore()

    # CSS filter
    .pipe cssFilter
    .pipe $.csso()                            # Minify CSS
    .pipe cssFilter.restore()

    .pipe assets.restore()
    .pipe $.useref()
    # End Assets filter

    .pipe $.revReplace()                      # Rewrite filenames refs to include the revision

    # HTML Filter
    .pipe htmlFilter
    .pipe $.minifyHtml(                       # Minify HTML
      empty: true
      spare: true
      quotes: true
    )
    .pipe htmlFilter.restore()

    .pipe gulp.dest(config.dest)
    .pipe $.size()


### HTML compliation for staging (no minification or file revisions) ###
gulp.task 'html_staging', ['styles_staging', 'scripts_staging', 'partials_staging', 'load_bowerrc'], ->
  gulp.src "#{config.src}/*.html"
    # Inject partials into the template
    .pipe $.inject(
      gulp.src("#{config.dest}/{app,components}/**/*.js", read: false, relative: true), {
        starttag: '<!-- inject:partials -->'
        ignorePath: config.dest
      }
    )
    .pipe gulp.dest(config.dest)
    .pipe $.size()

  gulp.src "#{bowerrc.directory}/**/*"
    .pipe gulp.dest("#{config.dest}/bower_components")
    .pipe $.size()


bowerrc = undefined
gulp.task 'load_bowerrc', ->
  fs = require 'fs'
  fs.readFile '.bowerrc', 'utf8', (err, data) ->
    bowerrc = JSON.parse data
