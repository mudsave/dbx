
(function(){
	'use strict';

	angular.module("BlurAdmin.pages.table.table2", [])
	.config(routeConfig);

	/** @ngInject */
	function routeConfig($stateProvider)
	{
		$stateProvider.state(
			'table.table2',
			{
				url: '/table2',
				templateUrl: 'app/pages/table/table2/table2.html',
				title: 'Role',
				sidebarMeta: {order:22}
			}
		);
	}
}
)();