'use strict'

angular.module 'frontendTemplate', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'ui.router']
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: 'app/main/main.html'
        controller: 'MainCtrl'

    $urlRouterProvider.otherwise '/'
