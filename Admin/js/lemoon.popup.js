var LemoonPopup = {
    /* ------------------------------------------------------------   
    - Initializes main functionallity.
    ------------------------------------------------------------ */
    init: function() {
    },

    ToggleDialog: function(id, state) {
        if (state == true) {
            $(id).modal({ persist: true });
        } else {
            $.modal.close();
        }
        return false;
    }
};

$(document).ready(function() {
    LemoonPopup.init();
});
