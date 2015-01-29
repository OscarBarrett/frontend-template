'use strict'

gulp = require 'gulp'

gulp.task 'watch', ['wiredep', 'styles'], ->
  gulp.watch 'src/{app,components}/**/*.scss', ['styles']
  gulp.watch 'src/{app,components}/**/*.coffee', ['scripts']
  gulp.watch 'src/assets/images/**/*', ['images']
  gulp.watch 'bower.json', ['wiredep']
