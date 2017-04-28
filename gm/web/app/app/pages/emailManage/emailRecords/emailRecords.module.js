(function () {
    'use strict';
    angular.module("BlurAdmin.pages.emailManager.emailRecords", [])
        .config(routeConfig)
        .controller('emailRecordsCtrl', ['$scope', '$http','$state', emailRecords])
        .controller('detailEmailCtrl', ['$scope', '$http','$stateParams', detailEmail]);

        var emailData = [
            { 'addresser': "哈姆雷特", 'theme': "给你的奖励也", 'time': "2017/4/24/15:06:58" },
            { 'addresser': "劳伦斯", 'theme': "给你的奖励也", 'time': "2017/4/24/15:06:58" },
            { 'addresser': "开普莱特", 'theme': "给你的奖励也", 'time': "2017/4/24/15:06:58" },
            { 'addresser': "提博尔特", 'theme': "给你的奖励也", 'time': "2017/4/24/15:06:58" }
        ];


    function routeConfig($stateProvider) {
        $stateProvider.state(
            'emailManager.emailRecords',
            {
                url: '/emailRecords',
                templateUrl: 'app/pages/emailManage/emailRecords/emailRecords.html',
                title: '邮件记录',
                sidebarMeta: { order: 100 },
                controller: 'emailRecordsCtrl',
            }
        ).state(
            'detaillEmail',
            {
                url: '/detailEmail/:index',
                templateUrl: 'app/pages/emailManage/emailRecords/detailEmail.html',
                controller: 'detailEmailCtrl'
            }
            )
    }

    function emailRecords($scope, $http,$state) {        
        $scope.emailrecords = emailData;
        $scope.checkDetail = function(index) {
            console.log("标记是第几条", index);
            $state.go('detaillEmail',{'index':index});
        }

    }



// 详细信息界面
function detailEmail($scope, $http,$stateParams){
    console.log("传过来的参数",$stateParams.index);
    var index = $stateParams.index;
    $scope.detailInfo = emailData[index];
    

}


})();