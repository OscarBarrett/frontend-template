angular.module 'routingService', ['ui.router']
  .config ($locationProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode !location.host.match(/(127.0.0.1|localhost|dev)/i)
    $urlRouterProvider.otherwise '/'

  .provider 'routingService', ($stateProvider) ->
    this.addState = (state, params) ->
      if !state? || !params.url?
        throw new Error

      controller = params.controller || ''
      data = params.data || {}
      
      pageTitle = params.pageTitle || state
      pageTitle = pageTitle.charAt(0).toUpperCase() + pageTitle.slice(1)

      $stateProvider
        .state state,
          pageTitle: pageTitle
          url: params.url
          views:
            content: { templateUrl: "app/states/#{state}/#{state}.html" }
          controller: controller
          data: data

    this.$get = ->
      (state, params) ->
        addStage(state, params)

    return
