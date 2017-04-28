(function(){
	'use strict';
	angular.module("BlurAdmin.pages.table.factionMgr",[]
	)
    .config(routeConfig)
    .controller('factionSearch', ['$scope','$http','editableOptions', 'editableThemes', facSearch])
    .controller('facMembersCtrl',['$scope','$http','editableOptions', 'editableThemes', facMembers]);

    function routeConfig($stateProvider)
        {
            $stateProvider.state(
                'table.factionMgr',
                {
                    url: '/facManager',
                    templateUrl: 'app/pages/table/factionMgr/faction.html',
                    title: '帮派管理',
                    sidebarMeta: {order:24},
                    controller: 'factionSearch'
                }
            ).state(
                'facMembers',
                {
                    url:'/MemberInfo/{facid:[0-9a-zA-Z]*}',
                    templateUrl: 'app/pages/table/factionMgr/facMember.html',
                    controller : 'facMembersCtrl'
                }
            );
        }
    //帮派信息查询
    function facSearch($scope,$http,editableOptions, editableThemes)    
	{
            $scope.searchFac = function(factionID){
            $scope.factionsInfo = [];
            if(factionID){
                $http({
				method: 'GET',
				url: '',
				}).then(
				function(response){
					if(response.flag)
					{
						$scope.factionsInfo = facInfo;
					}
					else{
						alert(response.message);
					}

				},
				function(response){
					console.log(response);
					alert();
				}
			)	
            }
        }
        
       var optionSelect = new Array();
        //可选择条件的检索
        $scope.optionSearch = function(){
            $scope.factionsInfo = [];
            //检索条件的添加
            optionSelect = [];
            if($scope.facName)        
                optionSelect["Name"] = $scope.facName;        
            if($scope.facLevel)
                optionSelect["Level"] = $scope.facLevel;
            if($scope.facOwner)
                optionSelect["Owner"] = $scope.facOwner;     
            if($scope.facFame)
                optionSelect["Fame"] = $scope.facFame;
            if($scope.facMoney)
                optionSelect["Money"] = $scope.facMoney;
            if($scope.facPeople)
                optionSelect["Member"] = $scope.facPeople;
            if($scope.mgrMoney)
                optionSelect["marMoney"] = $scope.mgrMoney; 

            optLength = Object.keys(optionSelect).length;
            if( optLength > 0 ){
                $http({
                    method:'GET',
                    url:'',
                    data: $.param(optionSelect),
                }).then(
                    function(response){
                       $scope.factionsInfo = response.data; 
                    },
                    function(response){
                        console.log(response);
                    }
                    )
                }
            };        
        
        $scope.downloadInfo = function(){
            
        };

        editableOptions.theme = 'bs3';
        editableThemes['bs3'].submitTpl = '<button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span></button>';
        editableThemes['bs3'].cancelTpl = '<button type="button" ng-click="$form.$cancel()" class="btn btn-info"><span class="glyphicon glyphicon-remove"></span></button>';
    }
    //帮派成员信息
    function facMembers($scope,$http, $stateParams,editableOptions, editableThemes) {
        console.log("帮派的ID",$stateParams.facID)
        $scope.facMembersData = {};
        $scope.isShow = false;
        $http({
				method: 'GET',
				url: '',
                data: $.param($stateParams.facID),
				}).then(
				function(response){
					if(response.flag)
					{	
                        $scope.facMembersData = response.data.rolesInfo;
						$scope.isShow  = true; 
					}
					else{
						$scope.message = esponse.data.message;
                        $scope.isShow = false;
					}
				},
				function(response){
                    // 失败的系统消息
					console.log(response);
					alert(response.error);
                    $scope.isShow = false;
				}
			)		
    }

})();