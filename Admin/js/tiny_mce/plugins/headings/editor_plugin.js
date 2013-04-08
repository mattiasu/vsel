/**
* Headings plugin
*
* Installation:
* Copy the headings directory to the plugins directory
* Add plugin to TinyMCE plugin option list
* Add heading buttons to button list
*
* Copyright 2011, Mindroute Software AB
*/
(function () {

  tinymce.create('tinymce.plugins.headings', {
    init: function (ed, url) {

      // register buttons
      ed.addButton('h1', { title: ed.getLang('advanced.h1', 'h1') + ' (Ctrl+1)', image: url + '/img/h1.png', onclick: function () { ed.execCommand('FormatBlock', false, 'h1'); } });
      ed.addButton('h2', { title: ed.getLang('advanced.h2', 'h2') + ' (Ctrl+2)', image: url + '/img/h2.png', onclick: function () { ed.execCommand('FormatBlock', false, 'h2'); } });
      ed.addButton('h3', { title: ed.getLang('advanced.h3', 'h3') + ' (Ctrl+3)', image: url + '/img/h3.png', onclick: function () { ed.execCommand('FormatBlock', false, 'h3'); } });
      ed.addButton('h4', { title: ed.getLang('advanced.h4', 'h4') + ' (Ctrl+4)', image: url + '/img/h4.png', onclick: function () { ed.execCommand('FormatBlock', false, 'h4'); } });
      ed.addButton('h5', { title: ed.getLang('advanced.h5', 'h5') + ' (Ctrl+5)', image: url + '/img/h5.png', onclick: function () { ed.execCommand('FormatBlock', false, 'h5'); } });
      ed.addButton('h6', { title: ed.getLang('advanced.h6', 'h6') + ' (Ctrl+6)', image: url + '/img/h6.png', onclick: function () { ed.execCommand('FormatBlock', false, 'h6'); } });

      // add a node change handler for activating/deactivating the buttons
      ed.onNodeChange.add(function (ed, cm, n) {
        var p = ed.dom.getParent(n, ed.dom.isBlock);
        if (p) {
          cm.setActive('h1', p.nodeName.toLowerCase() == 'h1');
          cm.setActive('h2', p.nodeName.toLowerCase() == 'h2');
          cm.setActive('h3', p.nodeName.toLowerCase() == 'h3');
          cm.setActive('h4', p.nodeName.toLowerCase() == 'h4');
          cm.setActive('h5', p.nodeName.toLowerCase() == 'h5');
          cm.setActive('h6', p.nodeName.toLowerCase() == 'h6');
        }
      });

    },

    getInfo: function () {
      return {
        longname: 'Headings plugin',
        author: 'Mindroute Software',
        authorurl: 'http://www.mindroute.com',
        version: '1.0'
      };
    }
  });

  tinymce.PluginManager.add('headings', tinymce.plugins.headings);
})();

