tinyMCEPopup.requireLangPack();
tinyMCEPopup.onInit.add(onLoadInit);

function saveContent() {
  tinyMCEPopup.editor.setContent(window.editor.getCode());
  tinyMCEPopup.close();
}

function onLoadInit() {
  tinyMCEPopup.resizeToInnerSize();

  // Remove Gecko spellchecking
  if (tinymce.isGecko)
    document.body.spellcheck = tinyMCEPopup.editor.getParam("gecko_spellcheck");

  loadCodeMirror();

  if (tinyMCEPopup.editor.getParam("theme_advanced_source_editor_wrap", true)) {
    var w = document.getElementById('wraped');
    w.checked = true;
    setWrap(true);
  }

  resizeInputs();
}

function setWrap(val) {
  if (window.editor) window.editor.setTextWrapping(val);
}

function toggleWordWrap(elm) {
  setWrap(elm.checked);
}

function resizeInputs() {
  var vp = tinyMCEPopup.dom.getViewPort(window), el;
  el = document.getElementById('source');
  if (el) {
    el.style.width = (vp.w - 20) + 'px';
    el.style.height = (vp.h - 65) + 'px';
  }

}

// Functions below added to support CodeMirror
function loadCodeMirror() {
  window.editor = new CodeMirror(CodeMirror.replace('htmlSource'), {
    parserfile: "parsexml.js",
    path: "js/",
    stylesheet: "css/xmlcolors.css",
    height: "100%",
    content: tinyMCEPopup.editor.getContent()
  });

  //window.focus();

  //  if (window.editor) {
  //    window.editor.focus();
  //    window.editor.jumpToLine(1);
  //  }
}

function indentAll() {
  if (window.editor) {
    var Code = window.editor.getCode();
    if (Code && Code != '') {
      window.editor.reindent();
      window.editor.jumpToLine(0);
    }
  }
}

function tidyAll() {
  if (window.editor) {
    var Code = window.editor.getCode();

    if (Code && Code != '') {
      Code = Code.replace(/>[ |\t]*</mig, '>\r\n<');
      window.editor.setCode(Code);
      window.editor.reindent();
      window.editor.jumpToLine(0);
    }
  }
}
