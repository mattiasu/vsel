/**
* CodeMirror plugin
*
* Copyright 2011, Mindroute Software AB
*/
(function () {
  // load plugin specific language pack
  tinymce.PluginManager.requireLangPack('codemirror');

  tinymce.create('tinymce.plugins.codemirror', {
    mceTout: 0,

    init: function (ed, url) {

      // register commands
      ed.addCommand('codemirror', function () {
        ed.windowManager.open({
          url: url + '/source.htm',
          width: parseInt(ed.getParam("theme_advanced_source_editor_width", 720)),
          height: parseInt(ed.getParam("theme_advanced_source_editor_height", 580)),
          inline: true,
          resizable: true,
          maximizable: true
        }, {
          theme_url: this.url
        });
      });

      // register buttons
      ed.addButton('codemirror', { title: ed.getLang('codemirror.title'), image: url + '/img/html.png', cmd: 'codemirror' });
    },

    getInfo: function () {
      return {
        longname: 'CodeMirror plugin',
        author: 'Mindroute Software',
        authorurl: 'http://www.mindroute.com',
        version: '1.0'
      };
    }
  });

  // Register plugin
  tinymce.PluginManager.add('codemirror', tinymce.plugins.codemirror);
})();
