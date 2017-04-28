/**
 * @author v.lugovksy
 * created on 16.12.2015
 */
(function () {
  'use strict';

  angular.module('BlurAdmin.theme.components')
      .directive('backTop', backTop);

  /** @ngInject */
  function backTop() {
    return {
      restrict: 'E',
      templateUrl: 'app/theme/components/backTop/backTop.html',
      controller: function () {
        $('#backTop').backTop({
          'position': 200,
          'speed': 100
        });
      }
    };
  }

})();


! function (o) {
    o.fn.backTop = function (e) {
        var n = this,
            i = o.extend({
                position: 400,
                speed: 500,
                color: "white"
            }, e),
            t = i.position,
            c = i.speed,
            d = i.color;
        n.addClass("white" == d ? "white" : "red" == d ? "red" : "green" == d ? "green" : "black"), n.css({
            right: 40,
            bottom: 40,
            position: "fixed"
        }), o(document).scroll(function () {
            var e = o(window).scrollTop();
            e >= t ? n.fadeIn(c) : n.fadeOut(c)
        }), n.click(function () {
            o("html, body").animate({
                scrollTop: 0
            }, {
                duration: 1200
            })
        })
    }
}(jQuery);