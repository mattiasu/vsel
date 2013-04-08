var LemoonLinkDialog = {
  preInit: function () {
  },

  init: function () {
  },

  InsertAction: function () {
    var inst = tinyMCEPopup.editor;
    var elm, elementArray, i, href;

    elm = inst.selection.getNode();
    elm = inst.dom.getParent(elm, "A");

    // check http:// and mailto:// prefix
    LemoonLinkDialog.CheckPrefix(document.forms['aspnetForm'].href);

    href = document.forms['aspnetForm'].href.value;

    // remove element if there is no href
    if (!href) {
      tinyMCEPopup.execCommand("mceBeginUndoLevel");
      i = inst.selection.getBookmark();
      inst.dom.remove(elm, 1);
      inst.selection.moveToBookmark(i);
      tinyMCEPopup.execCommand("mceEndUndoLevel");
      tinyMCEPopup.close();
      return;
    }

    // create new anchor elements
    tinyMCEPopup.execCommand("mceBeginUndoLevel");
    if (elm == null) {
      var sel = inst.selection.getContent();
      if (sel == null || sel == '') {
        // insert new link
        elm = inst.dom.create('a', { href: href }, href);
        LemoonLinkDialog.SetAllAttribs(elm);
        inst.selection.setNode(elm);
      } else {
        // link current selection
        inst.getDoc().execCommand("unlink", false, null);
        tinyMCEPopup.execCommand("CreateLink", false, "#mce_temp_url#", { skip_undo: 1 });
        elementArray = tinymce.grep(inst.dom.select("a"), function (n) { return inst.dom.getAttrib(n, 'href') == '#mce_temp_url#'; });
        for (i = 0; i < elementArray.length; i++) {
          elm = elementArray[i];
          LemoonLinkDialog.SetAllAttribs(elm);
        }
      }
    } else {
      LemoonLinkDialog.SetAllAttribs(elm);
    }

    tinyMCEPopup.execCommand("mceEndUndoLevel");
    LemoonLinkDialog.Close();
  },

  SetAttrib: function (elm, attrib, value) {
    var formObj = document.forms['aspnetForm'];
    var valueElm = formObj.elements[attrib.toLowerCase()];
    var dom = tinyMCEPopup.editor.dom;
    if (typeof (value) == "undefined" || value == null) {
      value = "";
      if (valueElm) {
        value = valueElm.value;
      }
    }
    dom.setAttrib(elm, attrib, value);
  },

  SetAllAttribs: function (elm) {
    var formObj = document.forms['aspnetForm'];
    LemoonLinkDialog.SetAttrib(elm, 'href');
    LemoonLinkDialog.SetAttrib(elm, 'title');
    LemoonLinkDialog.SetAttrib(elm, 'class');
    LemoonLinkDialog.SetAttrib(elm, 'target', formObj.target.checked ? '_blank' : '');
  },

  CheckPrefix: function (n) {
    if (n.value && Validator.isEmail(n) && !/^\s*mailto:/i.test(n.value) && confirm(tinyMCEPopup.editor.getLang('lemoonlink.is_email'))) {
      n.value = 'mailto:' + n.value;
    }
    if (/^\s*www./i.test(n.value) && confirm(tinyMCEPopup.editor.getLang('lemoonlink.is_external'))) {
      n.value = 'http://' + n.value;
    }
  },

  GetAnchorList: function () {
    var inst = tinyMCEPopup.editor;
    var nodes = inst.dom.select('a.mceItemAnchor,img.mceItemAnchor'), name, i;
    var html = "";

    html += '<option value="">---</option>';

    for (i = 0; i < nodes.length; i++) {
      if ((name = inst.dom.getAttrib(nodes[i], "name")) != "")
        html += '<option value="#' + name + '">' + name + '</option>';
    }

    if (nodes.length == 0) {
      $('#anchorContainer').hide();
    }
    else {
      $('#anchorContainer').show();
      $('#anchorlist').html(html);
    }
  },


  Close: function () {
    window.close();
  }
};

LemoonLinkDialog.preInit();
tinyMCEPopup.onInit.add(LemoonLinkDialog.init, LemoonLinkDialog);

$(function () {
  LemoonLinkDialog.GetAnchorList();
  var hrefValue = $('#href').val();
  if (hrefValue != '' && hrefValue.indexOf('#') == 0) {
    $("#anchorlist option[value='" + hrefValue + "']").attr('selected', 'selected');
  }
});