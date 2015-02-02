'use strict'

gulp = require 'gulp'

gulp.task 'watch', ['states', 'wiredep', 'styles', 'scripts'], ->
  gulp.watch 'src/index.html', ['states', 'wiredep']
  gulp.watch 'src/{app,components}/**/*.scss', ['styles']
  gulp.watch 'src/{app,components}/**/*.coffee', ['scripts']
  gulp.watch 'bower.json', ['wiredep']
