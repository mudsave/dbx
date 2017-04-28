(function () {
    'use strict';
    angular.module("BlurAdmin.pages.emailManager", [
        'BlurAdmin.pages.emailManager.sendEmail',
        'BlurAdmin.pages.emailManager.emailRecords'
    ])
        .config(routeConfig);

    function routeConfig($stateProvider) {
        $stateProvider.state(
            'emailManager',
            {
                url: '/emailManager',
                template: '<ui-view autoscroll="true" autoscroll-body-top></ui-view>',
                title: '邮件管理',
                sidebarMeta: {
                    icon: 'ion-email',
                    order: 150,
                },
            }
        )
    }

})();