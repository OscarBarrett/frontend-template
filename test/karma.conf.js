'use strict';

module.exports = function(config) {

  config.set({
    basePath : '..', //!\\ Ignored through gulp-karma //!\\

    files : [ //!\\ Ignored through gulp-karma //!\\
        'vendor/bower_components/angular/angular.js',
        'vendor/bower_components/angular/angular-route.js',
        'vendor/bower_components/angular-mocks/angular-mocks.js',
        'app/** /*.js',
        'test/unit/** /*.js'
    ],

    autoWatch : false,

    frameworks: ['jasmine'],

    browsers : ['PhantomJS'],

    plugins : [
        'karma-phantomjs-launcher',
        'karma-jasmine'
    ]
  });

};
