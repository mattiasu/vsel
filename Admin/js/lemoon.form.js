/****************************************************************************
* Register hidden javascript variable 'ConfirmLeavePagePhrase' 
* to set the message that is displayed.
*****************************************************************************/

var LemoonForm = {

    setIsDirty: function(bool) {
        if (bool == false) {
            LemoonForm.getOrignalTexts();
        }
        LemoonForm.isDirty = bool;
    },

    setNeedConfirm: function(bool) {
        LemoonForm.needConfirm = bool;
    },

    setCancelConfirm: function(bool) {
        LemoonForm.cancelConfirm = bool;
    },

    normaliseNewlines: function(input) {
        var reNewline = /\u000d[\u000a\u0085]|[\u0085\u2028\u000d\u000a]/g;
        nl = '\u000a'; // LF
        return input.replace(reNewline, nl);
    },

    init: function() {
        // register onbeforeunload handler.
        window.onbeforeunload = function(e) {
            var message = " ";

            if ($("#ConfirmLeavePagePhrase").length > 0) {
                message = $("#ConfirmLeavePagePhrase").val();
            }

            var boolConfirm = false;

            if (LemoonForm.needConfirm && !LemoonForm.cancelConfirm) {
                if (LemoonForm.isDirty) {
                    boolConfirm = true;
                } else {
                    $("textarea.lemooneditor").each(function(i) {
                        if (LemoonForm.orignalTexts[i].toString() != LemoonForm.normaliseNewlines(tinyMCE.getInstanceById($(this).attr("id")).getContent())) {
                            boolConfirm = true;
                        }
                    });
                }
            }
            // Reset.
            LemoonForm.setNeedConfirm(true);

            if (boolConfirm) {
                var e = e || window.event;

                // IE and Firefox
                if (e) {
                    e.returnValue = message;
                }
                // Safari
                return message;
            }
        };

        LemoonForm.isDirty = false;
        LemoonForm.needConfirm = true;
        LemoonForm.cancelConfirm = false;

        $("input").change(function() {
            LemoonForm.isDirty = true;
        });

        LemoonForm.orignalTexts = new Array();
        $("textarea.lemooneditor").each(function(i) {
            LemoonForm.orignalTexts[i] = LemoonForm.normaliseNewlines($(this).text());
        });
    },

    getOrignalTexts: function() {
        $("textarea.lemooneditor").each(function(i) {
            LemoonForm.orignalTexts[i] = LemoonForm.normaliseNewlines(tinyMCE.getInstanceById($(this).attr("id")).getContent());
        });
    }
};

$(document).ready(function() {
    LemoonForm.init();
});
