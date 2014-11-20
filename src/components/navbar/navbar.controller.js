'use strict';
angular.module('frontendTemplate').controller('NavbarCtrl', [
  '$scope', function($scope) {
    return $scope.date = new Date();
  }
]);
