angular.module 'frontendTemplate', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'routingService']
  .config (routingServiceProvider) ->
    routingServiceProvider.addState 'home',
      url: '/'

    routingServiceProvider.addState 'test',
      url: '/test'

    return

  .run ($rootScope, Utils) ->
    $rootScope.siteName = 'Frontend Template'

    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      # Ensure currentState is updated and available to views
      $rootScope.currentState = toState

      # Update body classes
      $rootScope.body_classes = Utils.classes_for_state(toState.name)
