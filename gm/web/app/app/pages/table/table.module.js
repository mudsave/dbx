/**
 * @author v.lugovsky
 * created on 16.12.2015
 */
(function () {
  'use strict';

  angular.module('BlurAdmin.pages.table', [
    "BlurAdmin.pages.table.roleMgr",
    "BlurAdmin.pages.table.factionMgr",
    "BlurAdmin.pages.table.activityManager",
    "BlurAdmin.pages.table.broadcast",
  ])
    .config(routeConfig);

  /** @ngInject */
  function routeConfig($stateProvider) {
    $stateProvider.state(
      'table',
      {
        url: '/table',
        template: '<ui-view autoscroll="true" autoscroll-body-top></ui-view>',
        title: '游戏管理',
        sidebarMeta: {
          icon: 'ion-grid',
          order: 20,
        },
      }
    )
  }

})();
