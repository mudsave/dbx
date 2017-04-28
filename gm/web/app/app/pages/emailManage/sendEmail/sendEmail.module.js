(function () {
    'use strict';
    angular.module("BlurAdmin.pages.emailManager.sendEmail", [])
        .config(routeConfig)
        .controller('sendEmailCtrl', ['$scope', '$http', sendEmail]);

    function routeConfig($stateProvider) {
        $stateProvider.state(
            'emailManager.sendEmail',
            {
                url: '/sendEmail',
                templateUrl: 'app/pages/emailManage/sendEmail/sendEmail.html',
                title: '发邮件',
                sidebarMeta: { order: 0 },
                controller: 'sendEmailCtrl',
            }
        )
    }


    function sendEmail($scope, $http) {
        $scope.formData = {}

        $scope.sendmail = function () {
            console.log($scope.formData);
            var data = $scope.formData;
            if (data.ids == null) {
                window.alert("内容不能为空");
            } else {
                $http({
                    method: 'GET',
                    url: 'http://172.16.4.126/php/index.php?c=index&a=sendmail',
                    params: data,
                }).then(
                    function (response) {
                        var data = response.data;
                        window.alert(data);

                    })
            }
        }
    }

})();