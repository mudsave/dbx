var app = angular.module("register", []);

app.controller('registerCtrl', ['$scope', '$http', '$window', function ($scope, $http, $window) {
    $scope.signInfo = {};
    var url = "http://172.16.2.218/php/index.php?c=login&a=verify_code"
    $scope.myVar = url;
    $scope.changeImg = function () {
        var timestamp = new Date().getTime();
        $scope.myVar = url + "&imgid=" + timestamp;
    }

    $scope.validateInfo = function (type) {

        switch (String(type)) {
            case "userName":
                if (!$scope.signInfo["userName"]) {
                    $scope.message = "用户名不能为空";
                }
                else
                    $scope.message = null;
                break;
            case "passKey":
                if (!$scope.signInfo["passKey"]) {
                    $scope.message = "密码不能为空";
                }
                else
                    $scope.message = null;
                break
            case "admin":
                if (!$scope.signInfo["admin"]) {
                    $scope.message = "请选择权限";
                }
                else
                    $scope.message = null;
                break;
            case "code":
                if (!$scope.signInfo["code"]) {
                    $scope.message = "请输入验证码";
                }
                else
                    $scope.message = null;
                break;

        }
    }

    $scope.signIn = function () {
        var flag = true;
        for (var key in $scope.signInfo) {
            if (!$scope.signInfo[key]) {
                $scope.message = "信息填写不完整耶";
                flag = false;
                break;
            }
        }
        if (flag) {
            $http({
                method: 'POST',
                url: '',
                params: $scope.signInfo,
            }).then(
                function (response) {
                    if (response.data) {
                        window.location.href = "login.html"
                    }
                    else {
                        $scope.message = response.data[1];
                        window.location.href = "register.html"
                    }
                }

                )
        }
    }


}]);