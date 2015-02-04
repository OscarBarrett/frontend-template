'use strict'

gulp              = require 'gulp'
build             = require '../build.coffee'
uglifySaveLicense = require 'uglify-save-license'
bowerrc           = build.bowerrc
$                 = build.$

gulp.task 'compress.all', ['compress.convertpartials', 'compress.injectpartials', 'compress.index', 'compress.images']

gulp.task 'compress.convertpartials', ->

  # Compress the partials
  gulp.src "#{GLOBAL.config.tmp}/{components,states}/**/*.html"
    .pipe $.minifyHtml(           # Minify
      empty: true
      spare: true
      quotes: true
    )
    .pipe $.ngHtml2js(            # Convert partials to js, storing them in $templateCache
      moduleName: GLOBAL.config.app_name
    )
    .pipe gulp.dest("#{GLOBAL.config.tmp}/partials")
    .pipe $.size()

gulp.task 'compress.injectpartials', ['compress.convertpartials'], ->

  # Inject the compressed partials into index
  gulp.src "#{GLOBAL.config.tmp}/index.html"
    .pipe $.inject(
      gulp.src("#{GLOBAL.config.tmp}/partials/**/*.js", read: false, relative: true),
      {
        starttag: '<!-- inject:partialhtml -->'
        ignorePath: GLOBAL.config.tmp
      }
    )
    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()

gulp.task 'compress.index', ['compress.injectpartials'], ->
  # Filters. Allows us to work on a subset of the original files.
  htmlFilter  = $.filter('*.html')
  jsFilter    = $.filter('**/*.js')
  cssFilter   = $.filter('**/*.css')
  assets      = undefined

  gulp.src "#{GLOBAL.config.tmp}/index.html"

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

    .pipe gulp.dest(GLOBAL.config.tmp)
    .pipe $.size()

gulp.task 'compress.images', ->
  gulp.src "#{GLOBAL.config.tmp}/assets/images/*"
    .pipe $.cache($.imagemin                  # Minify images. Note: this is cached!
      optimizationLevel: 3                    # If you move directories, you may need to clear the cache (`gulp init`)
      progressive: true
      interlaced: true
    )
    .pipe gulp.dest("#{GLOBAL.config.tmp}/assets/images") # Save to final destination
    .pipe $.size()
