
(function(){
	'use strict';
	
	angular.module("BlurAdmin.pages.table.sendmail", [])
	.config(routeConfig).controller('SendmailCtrl', ['$scope', '$http', SendmailCtrl]);

	/** @ngInject */
	function routeConfig($stateProvider)
	{
		$stateProvider.state(
			'table.sendmail',
			{
				url: '/sendmail',
				templateUrl: 'app/pages/table/sendmail/sendmail.html',
				title: '发送邮件',
				sidebarMeta: {order:27},
				controller: 'SendmailCtrl',
			}
		);
	}

  	function SendmailCtrl($scope, $http) {
		 // $http({
	      // method: 'POST',
	      // url: 'http://172.16.4.126/php/index.php?c=index&a=get_act_info',
	    // }).then(
	      // function(response){
	        // $scope.data = response.data;
	      // },
	      // function(response){
	        // console.log(response);
	      // }
	    // );
		$scope.formData = {}
		
		$scope.sendmail = function()
		{
			console.log($scope.formData);
			var data = $scope.formData;
			if (data.ids == null) 
			{
				window.alert("内容不能为空");
			}else
			{
				$http({
					method: 'GET',
					url: 'http://172.16.4.126/php/index.php?c=index&a=sendmail',
					params:data,		
				}).then(
					function(response){
					var data = response.data;
					window.alert(data);
					
			  })
			}
		}
  	}
}
)();