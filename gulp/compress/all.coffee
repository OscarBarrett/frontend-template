'use strict'

gulp              = require 'gulp'
build             = require '../build.coffee'
uglifySaveLicense = require 'uglify-save-license'

bowerrc = build.bowerrc
config  = build.config
$       = build.$

gulp.task 'compress.all', ['compress.index', 'compress.images', 'compress.convertpartials']

gulp.task 'compress.convertpartials', ->

  # Compress the partials
  gulp.src "#{config.tmp}/{components,states}/**/*.html"
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

gulp.task 'compress.injectpartials', ['compress.convertpartials'], ->

  # Inject the compressed partials into index
  gulp.src "#{config.tmp}/index.html"
    .pipe $.inject(
      gulp.src("#{config.tmp}/{states,components}/**/*.js", read: false, relative: true),
      {
        starttag: '<!-- inject:partials -->'
        ignorePath: config.tmp
      }
    )
    .pipe gulp.dest(config.tmp)
    .pipe $.size()

gulp.task 'compress.index', ['compress.injectpartials'], ->
  # Filters. Allows us to work on a subset of the original files.
  htmlFilter  = $.filter('*.html')
  jsFilter    = $.filter('**/*.js')
  cssFilter   = $.filter('**/*.css')
  assets      = undefined

  gulp.src "#{config.tmp}/index.html"

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

    .pipe gulp.dest(config.tmp)
    .pipe $.size()

gulp.task 'compress.images', ->
  gulp.src "#{config.tmp}/images/*"
    .pipe $.cache($.imagemin                  # Minify images. Note: this is cached!
      optimizationLevel: 3                    # If you move directories, you may need to clear the cache (`gulp init`)
      progressive: true
      interlaced: true
    )
    .pipe gulp.dest("#{config.tmp}/assets/images") # Save to final destination
    .pipe $.size()
