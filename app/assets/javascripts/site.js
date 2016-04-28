/**
 * Created by emivo on 28.4.2016.
 */
var myApp = angular.module('myApp', []);
myApp.controller("ProductsController", function ($scope, $http) {
    $http.get('products.json').success( function(data, status, headers, config) {
        $scope.products = data;
    });
    $scope.searchText = '';
});