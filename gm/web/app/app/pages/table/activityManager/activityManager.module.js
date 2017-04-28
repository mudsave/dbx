
(function(){
	'use strict';
	angular.module("BlurAdmin.pages.table.activityManager", [])
	.config(routeConfig).controller('ActivityManagerCtrl', ['$scope', '$http', ActivityManagerCtrl]);

	/** @ngInject */
	function routeConfig($stateProvider)
	{
		$stateProvider.state(
			'table.activityManager',
			{
				url: '/activityManager',
				templateUrl: 'app/pages/table/activityManager/activityManager.html',
				title: '活动管理',
				sidebarMeta: {order:25},
				controller: 'ActivityManagerCtrl',
			}
		);
	}

  	function ActivityManagerCtrl($scope, $http) {
	    $http({
	      method: 'POST',
	      url: 'http://172.16.4.126/php/index.php?c=index&a=get_act_info',
	    }).then(
	      function(response){
	        $scope.activityInfo = response.data;
					var item = response.data[0].activityTime[0]
					console.log("开始时间：",item.startTime);			
	      },
	      function(response){
	        console.log(response);
	      }
	    );
		$scope.startActivity = function(id)
		{
			console.log(id);
			var activityid = String(id)
			console.log(activityid);
			$http({
				method: 'GET',
				url: 'http://172.16.4.126/php/index.php?c=index&a=start_act',
				params:{'activityid':activityid}
			}).then(
				function(response){
				console.log(response);
				$scope.activityInfo = response.data;
	      })
		}
		$scope.closeActivity = function(id)
		{
			console.log(id);
			var activityid=String(id)
			console.log(activityid);
			$http({
				method: 'GET',
				url: 'http://172.16.4.126/php/index.php?c=index&a=close_act',
				params:{'activityid':activityid}
			}).then(
				function(response){
				 console.log(response);
				// $scope.activityInfo = {}
				$scope.activityInfo = response.data;
	      })
		}
  	}
}
)();