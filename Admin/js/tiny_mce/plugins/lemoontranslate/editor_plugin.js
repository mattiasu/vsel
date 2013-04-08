(function () {
  // load language pack
  tinymce.PluginManager.requireLangPack('lemoontranslate');

  tinymce.create('tinymce.plugins.LemoonTranslatePlugin', {
    init: function(ed, url) {
    },

    createControl: function(n, cm) {
      if (n == 'lemoontranslate') {
        var mlb = cm.createListBox('translatelist', {
          title: tinyMCE.activeEditor.getLang('lemoontranslate.desc'),
          onselect: function(languageCode) {
            $.translate(tinyMCE.activeEditor.getContent(), languageCode, { complete: function() {
              tinyMCE.activeEditor.execCommand('mceBeginUndoLevel');
              tinyMCE.activeEditor.setContent(this.translation);
              tinyMCE.activeEditor.execCommand('mceEndUndoLevel');
            }
            });
          }
        });

        mlb.add('Arabic', 'ar');
        mlb.add('Chinese', 'zh');
        mlb.add('Danish', 'da');
        mlb.add('English', 'en');
        mlb.add('Finnish', 'fi');
        mlb.add('French', 'fr');
        mlb.add('German', 'de');
        mlb.add('Greek', 'el');
        mlb.add('Italian', 'it');
        mlb.add('Norwegian', 'no');        
        mlb.add('Spanish', 'es');
        mlb.add('Swedish', 'sv');
        return mlb;
      }
      return null;
    },

    getInfo: function() {
      return {
        longname: 'Lemoon translate plugin',
        author: 'Mindroute Software AB',
        authorurl: 'http://www.mindroute.com',
        infourl: 'http://support.mindroute.com',
        version: "1.0"
      };
    }
  });

  // Register plugin
  tinymce.PluginManager.add('lemoontranslate', tinymce.plugins.LemoonTranslatePlugin);
})();
