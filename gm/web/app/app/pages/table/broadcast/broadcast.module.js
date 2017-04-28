
(function(){
	'use strict';
	
	angular.module("BlurAdmin.pages.table.broadcast", [])
	.config(routeConfig).controller('BroadcastCtrl', ['$scope', '$http', BroadcastCtrl]);

	/** @ngInject */
	function routeConfig($stateProvider)
	{
		$stateProvider.state(
			'table.broadcast',
			{
				url: '/broadcast',
				templateUrl: 'app/pages/table/broadcast/broadcast.html',
				title: '公告',
				sidebarMeta: {order:26},
				controller: 'BroadcastCtrl',
			}
		);
	}

  	function BroadcastCtrl($scope, $http) {
		 // $http({
	      // method: 'POST',
	      // url: 'http://172.16.4.126/php/index.php?c=role&a=get_role_info_by_dbid&DBID=6130',
	    // }).then(
	      // function(response){
	        // $scope.data = response.data;
	      // },
	      // function(response){
	        // console.log(response);
	      // }
	    // );
		$scope.formData = {}
		$scope.broadcast = function()
		{
			console.log($scope.formData)
			var data = $scope.formData;
			
			if(data.times == null)
			{
				data.times = 0;
			}
			if(data.period == null)
			{
				data.period = 0;
			}
			if (data.content == null) 
			{
				window.alert("内容不能为空");
			}else
			{
				$http({
					method: 'GET',
					url: 'http://172.16.4.126/php/index.php?c=index&a=broadcast',
					params:data,		
				}).then(
					function(response){
					// console.log(response);
					// window.alert("response");
					$scope.data = response.data;
			  })
			}
		}
  	}
}
)();