angular.module 'frontendTemplate', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'routingService']
  .config (routingServiceProvider) ->
    routingServiceProvider.addState 'main',
      url: '/'

    routingServiceProvider.addState 'test',
      url: '/test'

    return

  .run ($rootScope) ->
    $rootScope.siteName = 'Frontend Template'

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      console.log event
