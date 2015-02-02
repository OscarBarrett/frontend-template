'use strict'

gulp    = require 'gulp'
build   = require '../build.coffee'
config  = build.config
$       = build.$
bowerrc = build.bowerrc

uglifySaveLicense = require 'uglify-save-license'

### HTML compilation ###
gulp.task 'html', ['wiredep', 'styles', 'scripts', 'partials'], ->
  # Filters. Allows us to work on a subset of the original files.
  htmlFilter  = $.filter('*.html')
  jsFilter    = $.filter('**/*.js')
  cssFilter   = $.filter('**/*.css')
  assets      = undefined

  gulp.src "#{config.tmp}/index.html"
    # Inject partials into the template
    .pipe $.inject(
      gulp.src("#{config.tmp}/{app/states,components}/**/*.js", read: false),
      {
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
gulp.task 'html_staging', ['wiredep', 'styles_staging', 'scripts_staging', 'partials_staging'], ->

  gulp.src "#{config.tmp}/index.html"
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



gulp.task 'states', ['styles'], ->

  gulp.src "#{config.src}/index.html"
    .pipe $.inject(
      gulp.src("#{config.tmp}/app/states/**/*.css", read: false, relative: true),
      {
        starttag: '<!-- inject:statecss -->'
        ignorePath: config.tmp
      }
    )
    .pipe gulp.dest(config.tmp)
    .pipe $.size()
