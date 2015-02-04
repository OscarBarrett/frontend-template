gulp = require 'gulp'

require('require-dir')('./gulp') # Load tasks from gulp directory

merge = (options, overrides) ->
  extend (extend {}, options), overrides

extend = (object, properties) ->
  for key, val of properties
    object[key] = val
  object

GLOBAL.config = require './config.json'
GLOBAL.setBuildEnv = (env) ->
  GLOBAL.config = merge GLOBAL.config, require("./config/#{env}.json")

gulp.task 'default', ->
  gulp.start('build')
