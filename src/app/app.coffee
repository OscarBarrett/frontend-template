angular.module 'frontendTemplate', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'routingService']
  .config (routingServiceProvider) ->
    routingServiceProvider.addState 'home',
      url: '/'

    routingServiceProvider.addState 'test',
      url: '/test'

    return

  .run ($rootScope) ->
    $rootScope.siteName = 'Frontend Template'

    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      # Ensure currentState is updated and available to views
      $rootScope.currentState = toState
