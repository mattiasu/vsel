var clipboardArea;

var LemoonClipboard = {

    /* ------------------------------------------------------------   
    - 
    ------------------------------------------------------------ */
    init: function (area) {
        clipboardArea = area;
    },

    cut: function (contentID) {
        if (contentID == null) {
            contentID = LemoonProperties.ContentID;
        }
        if (contentID != 0) {
            LemoonClipboard.setClipboard(LemoonProperties.LanguageID, contentID, false);
        }
    },

    copy: function (contentID) {
        if (contentID == null) {
            contentID = LemoonProperties.ContentID;
        }
        if (contentID != 0) {
            LemoonClipboard.setClipboard(LemoonProperties.LanguageID, contentID, true);
            return false;
        } else {
            return true;
        }
    },

    paste: function (contentID) {
        if (contentID == null) {
            contentID = LemoonProperties.ContentID;
        }
        var message;
        $.ajax({
            url: Lemoon.RootUrl() + "admin/api/content/GetClipboardStatus",
            type: 'POST',
            cache: false,
            processData: false,
            dataType: 'json',
            success: function (data, textStatus) {
                if (data == null || data.Area != clipboardArea) {
                    return;
                }
                if (data.IsCopy) {
                    message = LemoonResources.ConfirmCopyPage.replace("{0}", data.Title);
                } else {
                    message = LemoonResources.ConfirmMovePage.replace("{0}", data.Title);
                }

                if (confirm(message)) {
                    if (data.IsCopy && data.Area != "file" && data.HasChildren && confirm(LemoonResources.ConfirmCopySubpages)) {
                        LemoonClipboard.processClipboard(LemoonProperties.LanguageID, contentID, true);
                    } else {
                        LemoonClipboard.processClipboard(LemoonProperties.LanguageID, contentID, false);
                    }
                }
            }
        });
    },

    setClipboard: function (languageID, contentID, isCopy) {
        $.ajax({
            url: Lemoon.RootUrl() + "admin/api/content/SetClipboard?languageID=" + languageID + "&contentID=" + contentID + "&area=" + clipboardArea + "&isCopy=" + isCopy,
            type: 'POST',
            cache: false,
            processData: false,
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Error: Copy failed.");
            },
            success: function (data, textStatus) {
                if (data.Status == "ok") {
                    // Enable paste.
                    if ($("#clip_paste").attr("disabled") == true) {
                        $(document).bind('keydown', 'Ctrl+V', function (evt) {
                            try {
                                LemoonClipboard.paste()
                                document.location.href = 'javascript:void(0);';
                            } catch (e) { };
                            evt.stopPropagation();
                            evt.preventDefault();
                            return false;
                        });
                        $("#clip_paste").click(function () { LemoonClipboard.paste() });
                        $("#clip_paste").attr("href", "javascript:void(0);");
                        $("#clip_paste").removeAttr("disabled");
                    }
                    Lemoon.ShowMessage(data.Message, "info", 1000);
                } else {
                    Lemoon.ShowMessage(data.Message, "alert", 5000);
                }
            }
        });
    },

    processClipboard: function (languageID, contentID, recursive) {
        $.ajax({
            url: Lemoon.RootUrl() + "admin/api/content/processclipboard?languageID=" + languageID + "&contentID=" + contentID + "&recursive=" + recursive,
            type: 'POST',
            cache: false,
            processData: false,
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("Error: Paste failed.");
            },
            success: function (data, textStatus) {
                if (data.Status == "ok") {
                    location.href = data.Message;
                } else {
                    Lemoon.ShowMessage(data.Message, "alert", 5000);
                }
            }
        });
    }
};

