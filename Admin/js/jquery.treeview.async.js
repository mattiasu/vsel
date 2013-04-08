/*
* Async Treeview 0.1 - Lazy-loading extension for Treeview
* 
* http://bassistance.de/jquery-plugins/jquery-plugin-treeview/
*
* Copyright (c) 2007 Jörn Zaefferer
*
* Dual licensed under the MIT and GPL licenses:
*   http://www.opensource.org/licenses/mit-license.php
*   http://www.gnu.org/licenses/gpl.html
*
* Revision: $Id$
*
*/

function loadSite(languageID, rootPath, rootPathForSite, fileArchive, container, cssClass) {
    var rooturl = Lemoon.RootUrl();

  $.ajax({
      url: rooturl + "admin/api/content/GetTreeBySite?languageID=" + languageID + "&rootPath=" + rootPath + "&rootPathForSite=" + rootPathForSite + "&fileArchive=" + fileArchive,
      type: 'POST',
      cache: false,
      processData: false,
      dataType: 'json',
      success: function (response, textStatus) {
          if (response != null) {
              var newUL = $("<ul />");
              newUL.addClass("tree").attr("id", container.attr("id"));
              if (cssClass != null) {
                  newUL.addClass(cssClass)
              }
              container.parent().append(newUL);
              container.remove();
              var branch = createContentNode(response, newUL);
              if (response.Children.length > 0) {
                  for (i = 0; i <= response.Children.length - 1; i++) {
                      createContentNode(response.Children[i], branch);
                  }
              } else {
                  branch.remove();
              }
              $("#" + newUL.attr("id")).treeview({
                  url: rooturl + "admin/api/content/GetTreeWithLanguage?languageid=" + languageID + "&id={0}&rootPath=" + rootPath + "&fileArchive=" + fileArchive + "&rootPathForSite=" + rootPathForSite,
                  rootpath: rooturl
              });
          }
      },
      error: function (xhr, textStatus, errorThrown) {
          alert('loadSite failed.');
      }
  });
}

function createContentNode(item, parent) {
  var current = $("<li/>");
  var anchor = $("<a/>").attr("title", item.Message).addClass(item.CssClass).data("id", item.ID || "");
  if (item.CssClass == "site") {
    current.addClass("open");
  }
  anchor.attr("href", item.Link.replace("{id}", item.ID));
  anchor.append($("<span/>").attr("class", "icon-12 " + item.Icon));
  anchor.append($("<span/>").attr("class", "title").text(item.Title));
  current.append(anchor);
  current.appendTo(parent);
  if (item.HasChildren || item.CssClass == "site") {
    var branch = $("<ul/>").appendTo(current);
    current.addClass("hasChildren");
    if (item.CssClass == "site") {
      return branch;
    }
  }
}

; (function($) {

  function load(settings, root, child, container) {
    var icon = $(child).parent().find('.icon-12');
    $(icon).toggleClass("loading");
    $.ajax({
      url: settings.url.replace('{0}', root),
      type: 'POST',
      cache: false,
      processData: false,
      dataType: 'json',
      success: function(response, textStatus) {
        function createNode(parent) {
          var current = $("<li/>");
          var anchor = $("<a/>").attr("href", this.Link).attr("title", this.Message).attr("class", this.CssClass).data("id",  this.ID || "");
          anchor.append($("<span/>").attr("class", "icon-12 " + this.Icon));
          anchor.append($("<span/>").attr("class", "title").text(this.Title));
          current.append(anchor);
          current.appendTo(parent);

          if (this.HasChildren) {
            var branch = $("<ul/>").appendTo(current);
            current.addClass("hasChildren");
          }
        }
        $.each(response.Children, createNode, [child]);
        $(container).treeview({ add: child });
        $(icon).toggleClass("loading");
      },
      error: function(xhr, textStatus, errorThrown) {
        // REVIEW: Try to get the message for the exception.
        alert(xhr.statusText);
      }
    });
  }

  var proxied = $.fn.treeview;
  $.fn.treeview = function(settings) {
    if (!settings.url) {
      return proxied.apply(this, arguments);
    }
    var container = this;
    var userToggle = settings.toggle;
    return proxied.call(this, $.extend({}, settings, {
      collapsed: true,
      toggle: function() {
        var $this = $(this);
        if ($this.hasClass("hasChildren")) {
          var childList = $this.removeClass("hasChildren").find("ul");
          load(settings,  $this.find("a").data("id"), childList.empty(), container);
        }
        if (userToggle) {
          userToggle.apply(this, arguments);
        }
      }
    }));
  };

})(jQuery);