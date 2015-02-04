'use strict'

angular.module 'frontendTemplate'
  .controller 'NavbarCtrl', ($scope) ->
    $scope.date = new Date()
