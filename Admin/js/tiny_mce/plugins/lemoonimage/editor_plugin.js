(function () {
  // load language pack
  tinymce.PluginManager.requireLangPack('lemoonimage');

  // initialize the plugin
  tinymce.create('tinymce.plugins.LemoonImagePlugin', {
    init: function (ed, url) {

      // register the plugin command
      ed.addCommand('mceLemoonImage', function () {

        // get attributes if current element is an img.
        var action = 'insert';
        var q = '';
        var attrs;
        var elm = ed.selection.getNode();
        if (elm != null && elm.nodeName == 'IMG') {
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
      ed.addButton('lemoonimage', {
        title: 'lemoonimage.desc',
        cmd: 'mceLemoonImage',
        image: url + '/img/button.png'
      });

      ed.onNodeChange.add(function (ed, cm, n, co) {
        cm.setActive('lemoonimage', n.nodeName == 'IMG' && !n.name);
      });
    },

    getInfo: function () {
      return {
        longname: 'Lemoon image plugin',
        author: 'Mindroute Software AB',
        authorurl: 'http://www.mindroute.com',
        infourl: 'http://support.mindroute.com',
        version: "1.0"
      };
    }
  });

  // Register plugin
  tinymce.PluginManager.add('lemoonimage', tinymce.plugins.LemoonImagePlugin);
})();
