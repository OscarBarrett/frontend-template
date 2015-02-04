'use strict'

gulp = require 'gulp'

gulp.task 'compile.all', ['compile.inject.all','compile.interpret.all','compile.move.all']
