gulp = require 'gulp'

require('require-dir')('./gulp') # Load tasks from gulp directory

gulp.task 'default', ->
  gulp.start('build')
