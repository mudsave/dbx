/**
 * @author v.lugovsky
 * created on 16.12.2015
 */
(function () {
  'use strict';

  angular.module('BlurAdmin.pages', [
    'ui.router',

    'BlurAdmin.pages.dashboard',
    'BlurAdmin.pages.table',
    'BlurAdmin.pages.emailManager'
  ]).config(routeConfig);

  /** @ngInject */
  function routeConfig($urlRouterProvider, baSidebarServiceProvider, $stateProvider) {
    $urlRouterProvider.otherwise('/dashboard');

    baSidebarServiceProvider.addStaticItem({
      title: '账号管理',
      icon: 'ion-document',
      subMenu: [{
        title: '登录',
        fixedHref: 'login.html',
        blank: true
      },
      {
        title: '添加GM账号',
        fixedHref: 'register.html',
        blank: true
      }]
    });
  }


})();
