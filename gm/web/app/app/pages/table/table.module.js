/**
 * @author v.lugovsky
 * created on 16.12.2015
 */
(function () {
  'use strict';

  angular.module('BlurAdmin.pages.table', [
    "BlurAdmin.pages.table.table1",
    "BlurAdmin.pages.table.table2",
    ])
    .config(routeConfig);

  /** @ngInject */
  function routeConfig($stateProvider) {
    $stateProvider .state(
      'table',
      {
        url: '/table',
        template : '<ui-view autoscroll="true" autoscroll-body-top></ui-view>',
        title: 'Table',
        sidebarMeta: {
          icon: 'ion-grid',
          order: 20,
        },
      }
    );
  }

})();
