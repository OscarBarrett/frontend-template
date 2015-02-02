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

      $stateProvider
        .state state,
          url: params.url
          views:
            content: { templateUrl: "app/states/#{state}/#{state}.html" }
          controller: controller
          data: data
          resolve:
            style: ->
              angular.element('head #partial-style').remove('')
              angular.element('head').append('<link id="partial-style" rel="stylesheet" href="app/styles/' + state + '.css">')

    this.$get = ->
      (state, params) ->
        addStage(state, params)

    return
