#$$inject_file:lib/utils.coffee$$

angular.module 'lib.templateRouter', ['ui.router']
  .config ($locationProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode !$$replace:devmode$$
    $urlRouterProvider.otherwise '/'

  .provider 'routingService', ($stateProvider) ->
    this.addState = (state, params) ->
      if !state?
        throw new Error

      parent_state = state.split('.')[0]
      title = parent_state.replace(/(_|-)/g, ' ')
                          .replace(/(?:^|\s)\S/g, (a) -> a.toUpperCase())

      defaultOptions = {
        controller: ''
        data:       {}
        url:        '/' + state.replace(/(home|root|main)/,'')
        pageTitle:  title
        views: {
          content: { templateUrl: "states/#{parent_state}/#{state}.html" }
        }
      }

      $stateProvider.state state, merge(defaultOptions, params)

    this.$get = ->
      (state, params) ->
        addState(state, params)

    return
