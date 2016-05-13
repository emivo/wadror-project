/**
 * Created by emivo on 28.4.2016.
 */
angular.module('myApp', [])
    .controller("ProductsController", function ($scope, $http) {
    $http.get('products_all.json').success( function(data, status, headers, config) {
        $scope.products = data;
    });
    $scope.searchText = '';
});
