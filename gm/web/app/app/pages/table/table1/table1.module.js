
(function(){
	'use strict';
	angular.module("BlurAdmin.pages.table.table1", [])
	.config(routeConfig).controller('TablesPageCtrl', ['$scope', '$http', TablesPageCtrl]);

	/** @ngInject */
	function routeConfig($stateProvider)
	{
		$stateProvider.state(
			'table.table1',
			{
				url: '/table1',
				templateUrl: 'app/pages/table/table1/table1.html',
				title: 'Accounts',
				sidebarMeta: {order:21},
				controller: 'TablesPageCtrl',
			}
		);
	}

  	function TablesPageCtrl($scope, $http) {
	    $http({
	      method: 'POST',
	      url: 'http://172.16.2.218/index.php?c=index&a=accounts',
	    }).then(
	      function(response){
	        $scope.accountInfo = response.data;
	      },
	      function(response){
	        console.log(response);
	      }
	    );
  	}
}
)();