gulp = require 'gulp'
utils = require('./lib/utils.coffee')

require('require-dir')('./gulp') # Load tasks from gulp directory

GLOBAL.config = require './config.json'
GLOBAL.setBuildEnv = (env) ->
  GLOBAL.config = utils.merge GLOBAL.config, require("./config/#{env}.json")

gulp.task 'default', ->
  gulp.start('build')
