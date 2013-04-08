var LemoonImageDialog = {
  preInit: function () {
  },

  init: function () {
  },

  IsExternal: function () {
    if ($("#seltype").length) {
      return $("#src").val().indexOf('/file/') == -1 && $("#src").val().indexOf('/thumb/') == -1;
    } else {
      return true;
    }
  },

  InsertAction: function () {
    // check http:// prefix
    var formObj = document.forms['aspnetForm'];
    LemoonImageDialog.CheckPrefix(formObj.src);

    var filetype = '';
    if (LemoonImageDialog.IsExternal()) {
      var src = $("#src").val();
      // check src for filetype based on file extension
      if (/.(jpg|gif|png)$/i.test(src)) {
        filetype = "image";
      }
    } else {
      filetype = $("#seltype").val();
    }

    if (filetype == "image") {
      LemoonImageDialog.InsertImageAction();
    } else if (filetype == "video") {
      LemoonImageDialog.InsertVideoAction();
    } else {
      LemoonImageDialog.InsertFileAction();
    }
  },

  InsertImageAction: function () {
    var formObj = document.forms['aspnetForm'];
    var inst = tinyMCEPopup.editor;
    var elm = inst.selection.getNode();
    var src, width, height, selwidth, selheight;

    src = formObj.src.value;
    width = Number(formObj.width.value);
    height = Number(formObj.height.value);

    if (!LemoonImageDialog.IsExternal()) {
      selwidth = Number(formObj.selwidth.value);
      selheight = Number(formObj.selheight.value);
      if ((width != 0 && width != selwidth || height != 0 && height != selheight) && $("input[name=thumb]:checked").val() != 'original') {
        // insert thumbnail
        src = formObj.thumbsrc.value;
        if (width != selwidth) {
          src = src.replace("0x", width + "x");
        } else {
          width = 0;
        }
        if (height != selheight) {
          src = src.replace("x0", "x" + height);
        } else {
          height = 0;
        }
      } else {
        // use original file and dimensions
        src = formObj.selsrc.value
        width = Number(formObj.selwidth.value);
        height = Number(formObj.selheight.value);
      }

      if ((LemoonCrop.Width == 0 && LemoonCrop.Height == 0) || $("input[name=thumb]:checked").val() == 'thumb') {
        src = src.replace("XxY-", "");
      }
      else {
        src = src.replace("XxY-", LemoonCrop.X + "x" + LemoonCrop.Y + "-");
      }
    }

    if (width == 0) width = '';
    if (height == 0) height = '';

    tinyMCEPopup.execCommand("mceBeginUndoLevel");
    if (elm != null && elm.nodeName == 'IMG') {
      LemoonImageDialog.SetAttrib(elm, 'src', src);
      LemoonImageDialog.SetAttrib(elm, 'alt');
      LemoonImageDialog.SetAttrib(elm, 'class');
      LemoonImageDialog.SetAttrib(elm, 'width', width);
      LemoonImageDialog.SetAttrib(elm, 'height', height);
      LemoonImageDialog.SetAlign(elm);
    } else {
      elm = inst.dom.create('img', { src: src, alt: '' });
      LemoonImageDialog.SetAttrib(elm, 'alt');
      LemoonImageDialog.SetAttrib(elm, 'class');
      LemoonImageDialog.SetAttrib(elm, 'width', width);
      LemoonImageDialog.SetAttrib(elm, 'height', height);
      LemoonImageDialog.SetAlign(elm);
      inst.selection.setNode(elm);
    }

    tinyMCEPopup.execCommand("mceEndUndoLevel");
    LemoonImageDialog.Close();
  },

  InsertVideoAction: function () {
    var formObj = document.forms['aspnetForm'];
    var inst = tinyMCEPopup.editor;
    var elm = inst.selection.getNode();
    var src, alt, width, height, css;

    src = formObj.src.value;
    alt = formObj.alt.value;
    if (!LemoonImageDialog.IsExternal() && alt == '') {
      alt = formObj.seltitle.value
    }

    width = Number(formObj.width.value);
    height = Number(formObj.height.value);
    css = "media { ";
    if (!isNaN(width) && width > 0) {
      css += "width:'" + width + "', ";
    }
    if (!isNaN(height) && height > 0) {
      css += "height:'" + height + "', ";
    }
    css += 'caption: false, autoplay: false }';

    tinyMCEPopup.execCommand("mceBeginUndoLevel");
    elm = inst.dom.create('a', { href: src }, alt);
    LemoonImageDialog.SetAttrib(elm, 'class', css);
    LemoonImageDialog.SetAlign(elm);
    inst.selection.setNode(elm);
    tinyMCEPopup.execCommand("mceEndUndoLevel");
    LemoonImageDialog.Close();
  },

  InsertFileAction: function () {
    var formObj = document.forms['aspnetForm'];
    var inst = tinyMCEPopup.editor;
    var elm = inst.selection.getNode();
    var src = formObj.src.value;
    var alt = formObj.alt.value;
    var title = src;

    if (!LemoonImageDialog.IsExternal()) {
      title = formObj.seltitle.value
    }

    tinyMCEPopup.execCommand("mceBeginUndoLevel");
    elm = inst.dom.create('a', { href: src }, title);
    LemoonImageDialog.SetAttrib(elm, 'title', alt);
    LemoonImageDialog.SetAttrib(elm, 'class');
    inst.selection.setNode(elm);
    tinyMCEPopup.execCommand("mceEndUndoLevel");
    LemoonImageDialog.Close();
  },

  SetAlign: function (elm) {
    $(elm).removeClass("align-left");
    $(elm).removeClass("align-center");
    $(elm).removeClass("align-right");

    var value = $("input[name=align]:checked").val();
    if (typeof (value) != "undefined" && value != null && value != "") {
      $(elm).addClass(value);
    }
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

  CheckPrefix: function (n) {
    if (/^\s*www./i.test(n.value) && confirm(tinyMCEPopup.editor.getLang('lemoonimage.is_external'))) {
      n.value = 'http://' + n.value;
    }
  },

  Close: function () {
    window.close();
  }
}

tinyMCEPopup.onInit.add(LemoonImageDialog.init, LemoonImageDialog);