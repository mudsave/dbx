
(function () {
	'use strict';
	angular.module("BlurAdmin.pages.table.roleMgr", []
	)
		.config(routeConfig)
		.controller('searchPlayer', ['$scope', '$http', 'editableOptions', 'editableThemes', EditPlayer])
		.controller('myProfile', ['$scope', '$http', '$stateParams', myProfile]);

	/** @ngInject */
	function routeConfig($stateProvider) {
		$stateProvider.state(
			'table.roleMgr',
			{
				url: '/factionMgr',
				templateUrl: 'app/pages/table/roleMgr/search.html',
				title: '角色管理',
				sidebarMeta: { order: 23 },
				controller: 'searchPlayer'
			}
		).state(
			'roleDetail',
			{
				url: '/roleDetailInfo/{roleid:[0-9a-zA-Z]*}',
				templateUrl: 'app/pages/table/roleMgr/profile/profile.html',
				controller: 'myProfile'
			}
			);
	}

	function EditPlayer($scope, $http, editableOptions, editableThemes) {		
		$scope.isShow = false;
		$scope.beShow = true;
		$scope.hasShow = false;

		$scope.roleData = {};
		// 检索界面的函数
		$scope.searchRole = function () {
			$scope.isShow = false;
			$scope.beShow = false;
			$scope.hasShow = false;
			if ($scope.searchKey == "1") {
				$http({
					method: 'GET',
					url: 'http://172.16.4.126/php/index.php?c=role&a=get_role_info_by_dbid',
					params: { "id": $scope.condition},
				}).then(
					function (response) {
						if (response.data.result) {
							$scope.roleData = response.data.msg;
							$scope.isShow = true;
						}
						else {
							alert(response.data.msg);
						}
					},
					function (response) {
						console.log("怎么就失败了呢");
					}
					)
			}
			else if ($scope.searchKey == "2") {
				$http({
					method: 'GET',
					url: 'http://172.16.4.126/php/index.php?c=role&a=get_role_info_by_name',
					params: { "name": $scope.condition},
				}).then(
					function (response) {
						if (response.data.result) {
							$scope.roleData = response.data.msg;
							$scope.beShow = true;
						}
						else {
							alert(response.data.result);
						}
					},
					function (response) {
						console.log(response.state);
					}
					)
			}
			else if($scope.searchKey == "3"){
				$http({
					method:'GET',
					url:'',
					params:{'name':$scope.condition},
				}).then(
					function(response){
						if(response.data.result){
							$scope.hasShow = true;
							$scope.upLvlInfo = response.data.data[0]
							$scope.upLvlData = response.data.data[0].records
						}

					},
					function(){

					}
				)
			}
		}

		//玩家基本信息界面
		//删除玩家
		$scope.deleteRole = function (roleData) {
			console.log("delete RoleID: " + roleData.id);
			$scope.offLine = true;
			roleData.offLine = $scope.offLine;
			$scope["noSpeek"] = true;

		}

		$scope.checkRoleInfo = function (roleData) {
			console.log("checkRoleInfo RoleID: " + roleData.id);
			$scope.noSpeek = true;
			roleData["noSpeek"] = $scope.noSpeek;

		}
		//玩家位置界面
		//复位玩家位置
		$scope.restore = function (DBID,mapid) {
			if (DBID) {
				$http({
					method: 'GET',
					url: 'http://172.16.4.126/php/index.php?c=role&a=reset_postion',
					params: { "id":DBID,"mapID":mapid},
				}).then(
					function (response) {
						if (response.data.result == 1) {
							$scope.roleData = response.data.msg;
							$scope.beShow = true;
						}
						else
						{
							alert(response.data.msg);
						}
					},
					function (response) {
						console.log(response.state);
					}
					)
			}

		}
		
		//保存修改的玩家的位置信息
		//保存修改的玩家的位置信息
		$scope.saveRolePos = function(data, dbid){
			console.log("保存的数据有哪些",data)
			data.id = dbid	
			$http({
				method:'GET',
				url:'http://172.16.4.126/php/index.php?c=role&a=set_role_postion',
				params:data,
			}).then(
				function(response){
					if (response.result == 1)
					{
						$scope.roleData = response.data.msg;
					}else
					{
						alert(response.data.msg);
					}
				},
				function (response) {
					console.log(response.state);
				}
				)
		}



		editableOptions.theme = 'bs3';
		editableThemes.bs3.inputClass = 'input-sm';
		editableThemes.bs3.buttonsClass = 'btn-sm';

	}

	function myProfile($scope, $http, $stateParams) {
		console.log($stateParams.roleid);
		$scope.roleInfo = {};
		$scope.isShow = false;
		$http({
			method: 'GET',
			url: '',
			data: $.param($stateParams.roleid),
		}).then(
			function (response) {
				if (response.data) {
					$scope.roleInfo = response.data;
					$scope.current = 200;
					$scope.maxMp = 600;
					$scope.style = { width: ($scope.current / $scope.maxMp) * 100 + "%" };
					$scope.isShow = true;
				}
				else {
					$scope.message = response.status;
				}

			},
			function (response) {
				// 失败的系统消息
				console.log(response);
				alert(response.error);
			}
			)
	}
}
)();