/*
* jQuery version of the spamspan code at http://www.spamspan.com
* Copyright 2010, Mindroute Software
*/

(function ($) {
  $.fn.spamspan = function (options) {

    var settings = {
      'spamSpanMainClass': 'spamspan',
      'spamSpanUserClass': 'u',
      'spamSpanDomainClass': 'd',
      'spamSpanAnchorTextClass': 't'
    };

    return this.each(function () {
      // if options exist, lets merge them with our default settings
      if (options) {
        $.extend(settings, options);
      }

      $("span." + settings.spamSpanMainClass, this).each(function (index) {
        // for each such span, set mail to the relevant value, removing spaces	
        var _mail = ($("span." + settings.spamSpanUserClass, this).text() + "@" + $("span." + settings.spamSpanDomainClass, this).text()).replace(/\s+/g, '').replace(/\[dot\]/g, '.');
        // find the anchor text, and remove the round brackets from the start and end
        var _anchorText = $("span." + settings.spamSpanAnchorTextClass, this).text().replace(/^ \((.*)\)$/, "$1");
        // create the <a> element, and replace the original span contents
        $(this).after($("<a></a>").attr("href", "mailto:" + _mail).html(_anchorText ? _anchorText : _mail).addClass(settings.spamSpanMainClass)).remove();
      });
    });
  };
})(jQuery);