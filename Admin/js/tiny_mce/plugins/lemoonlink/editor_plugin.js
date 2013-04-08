(function () {
  // load language pack
  tinymce.PluginManager.requireLangPack('lemoonlink');

  // initialize the plugin
  tinymce.create('tinymce.plugins.LemoonLinkPlugin', {
    init: function (ed, url) {

      // register the plugin command
      ed.addCommand('mceLemoonLink', function () {

        // get attributes if current element is an anchor.
        var action = 'insert';
        var q = '';
        var attrs;
        var elm = ed.selection.getNode();
        elm = ed.dom.getParent(elm, "A");
        if (elm != null && elm.nodeName == 'A') {
          q = 'action=update';
          attrs = ed.dom.getAttribs(elm);
          for (var i = 0; i < attrs.length; i++) {
            if (attrs[i].nodeName.indexOf('_') != 0) {
              q += '&' + encodeURIComponent(attrs[i].nodeName) + '=' + encodeURIComponent(ed.dom.getAttrib(elm, attrs[i].nodeName, ''));
            }
          }
        }

        ed.windowManager.open({
          url: url + '/default.aspx?' + q,
          width: 800,
          height: 600,
          resizable: true,
          scrollbars: true,
          popup_css: false // disable TinyMCE's default popup CSS
        }, {
          plugin_url: url
        });
      });

      // register button
      ed.addButton('lemoonlink', {
        title: 'lemoonlink.desc',
        cmd: 'mceLemoonLink',
        image: url + '/img/lemoonlink-button.gif'
      });


      ed.onNodeChange.add(function (ed, cm, n, co) {
        cm.setActive('lemoonlink', n.nodeName == 'A' && !n.name);
      });
    },

    getInfo: function () {
      return {
        longname: 'Lemoon link plugin',
        author: 'Mindroute Software AB',
        authorurl: 'http://www.mindroute.com',
        infourl: 'http://support.mindroute.com',
        version: "1.0"
      };
    }
  });

  // Register plugin
  tinymce.PluginManager.add('lemoonlink', tinymce.plugins.LemoonLinkPlugin);
})();
