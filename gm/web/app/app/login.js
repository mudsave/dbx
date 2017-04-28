
var app = angular.module("myLogin", []);

app.controller('loginCtrl',['$scope', '$http', '$window',function($scope, $http, $window){
    var url = "http://172.16.2.218/php/index.php?c=login&a=verify_code"
    $scope.myVar = url;  
    $scope.changeCodeImg = function(){
        var timestamp = new Date().getTime();
        $scope.myVar = url + "&imgid="+ timestamp;
    }
    $scope.processForm = function() {
        if (!$scope.username){
                alert("用户名为空！"); 
                return;          
            }        

        if(!$scope.passwd){
                alert("密码为空！");
                return;
        }
    
        if(!$scope.code){
            alert("请填写正确的验证码！");
            return;
        } 
    
        $http({
				method: 'POST',
				url: 'http://172.16.2.218/php/index.php?c=login&a=signin&username=admin&passwd=admin&code=pkuv',
               	params:{'username':$scope.username,'passwd':$scope.passwd,'code':$scope.code},
				}).then(
				function(response){
					if(response.data[0])
					{
                       window.location.href = "index.html" 
					}
					else{
						$scope.message = response.data[1];
                        window.location.href = "index.html" 
					}

				},
				function(response){
                    // 失败的系统消息
					console.log(response);
					alert();
				}
			)
      };



}]);