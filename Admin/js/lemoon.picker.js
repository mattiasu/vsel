var LemoonPicker = {
    /* ------------------------------------------------------------   
    - Sets watermark text
    - Binds click function for opening picker
    - Binds click function for clearing picker values
    ------------------------------------------------------------ */
    init: function () {

        // set watermark
        $('.field.picker :input[type=text]').watermark(LemoonResources.ClickToSelect + '...');

        // open picker
        $('.field.picker .open-picker').click(function () {
            //  populate settings
            LemoonPicker.Settings.field = $(this).closest('.picker');
            LemoonPicker.Settings.isInner = LemoonPicker.Settings.field.hasClass('inner');
            LemoonPicker.Settings.isMulti = LemoonPicker.Settings.field.hasClass('multi');
            LemoonPicker.Settings.isRole = LemoonPicker.Settings.field.hasClass('role');
            LemoonPicker.Settings.isUser = LemoonPicker.Settings.field.hasClass('user');
            LemoonPicker.Settings.isSystem = LemoonPicker.Settings.field.hasClass('system');
            LemoonPicker.Settings.isSite = LemoonPicker.Settings.field.hasClass('site');
            LemoonPicker.Settings.isFile = $(this).hasClass('file');
            LemoonPicker.Settings.isFolder = $(this).hasClass('folder');

            // select correct picker
            if (LemoonPicker.Settings.isUser) {
                LemoonPicker.OpenUserPicker();
            } else if (LemoonPicker.Settings.isRole) {
                LemoonPicker.OpenRolePicker();
            } else {
                LemoonPicker.OpenContentPicker();
            }
        });

        // clear picker value
        $('.field.picker .clear-picker').click(function () {
            var field = $(this).closest('.picker');
            if (field.hasClass('multi')) {
                $('option:selected', field).remove();
            } else {
                $(':input', field).removeAttr('title').val('');
                $('.preview', field).remove();
            }
        });

        // sort options in multi picker
        $('.field.picker. .arrow-up').click(function () {
            var field = $(this).closest('.picker');
            $('option:selected', field).each(function () {
                $(this).insertBefore($(this).prev());
            });
        });
        $('.field.picker. .arrow-down').click(function () {
            var field = $(this).closest('.picker');
            $('option:selected', field).each(function () {
                $(this).insertAfter($(this).next());
            });
        });

    },

    Settings: {
        field: null, // current field
        isInner: false,
        isMulti: false, // select many
        isSite: false, // possible to select site in content picker
        isFile: false, // file picker
        isFolder: false, // folder picker
        isUser: false, // user picker
        isRole: false, // role picker
        isSystem: false // include system roles in role picker
    },

    OpenUserPicker: function () {
        var url = Lemoon.AdminUrl() + "popups/userfield.aspx";
        var qs = '';
        var arr = new Array();
        if (this.Settings.isMulti) {
            arr.push('ismulti=1');
        }
        if (arr.length > 0) {
            url += '?' + arr.join('&');
        }
        this.OpenPopup(url);
    },

    OpenUserPickerForPermissions: function () {
        var url = Lemoon.AdminUrl() + "popups/userfield.aspx";
        var arr = new Array();
        arr.push('ismulti=1');
        arr.push('ispermission=1');
        url += '?' + arr.join('&');
        this.OpenPopup(url);
    },

    OpenRolePicker: function () {
        var url = Lemoon.AdminUrl() + "popups/rolefield.aspx";
        var qs = '';
        var arr = new Array();
        if (this.Settings.isMulti) {
            arr.push('ismulti=1');
        }
        if (this.Settings.isSystem) {
            arr.push('issystem=1');
        }
        if (arr.length > 0) {
            url += '?' + arr.join('&');
        }
        this.OpenPopup(url);
    },

    OpenRolePickerForPermissions: function () {
        var url = Lemoon.AdminUrl() + "popups/rolefield.aspx";
        var arr = new Array();
        arr.push('ismulti=1');
        arr.push('ispermission=1');
        arr.push('issystem=1');
        url += '?' + arr.join('&');
        this.OpenPopup(url);
    },

    OpenContentPicker: function () {
        var url = Lemoon.AdminUrl() + "popups/" + (this.Settings.isFile ? "filefield.aspx" : "contentfield.aspx");
        var qs = '';
        var arr = new Array();
        if (this.Settings.isMulti) {
            arr.push('ismulti=1');
        } else {
            // get contentid and siteid from hidden field
            var val = $(':input[type=hidden]', this.Settings.field).val();
            if (val != '') {
                var ids = val.split("/");
                arr.push('site=' + ids[1]);
                arr.push('id=' + ids[0]);
            }
        }

        if (this.Settings.isSite) {
            arr.push('issite=1');
        }
        if (this.Settings.isFolder) {
            arr.push('isfolder=1');
        }
        if (arr.length > 0) {
            url += '?' + arr.join('&');
        }

        this.OpenPopup(url);
    },


    SetValue: function (name, value, desc) {
        $(':input[type=hidden]', this.Settings.field).val(value);
        $(':input[type=text]', this.Settings.field).removeAttr('title').val(name);

        // set description/thumbnail
        $('.preview', this.Settings.field).remove();
        if (desc.indexOf("/thumb/") != -1) {
            this.Settings.field.append('<div class="preview"><img src="' + desc + '" alt="" /></div>');
        } else {
            $(':input[type=text]', this.Settings.field).attr('title', desc);
        }
    },

    AddValue: function (name, value, desc) {
        var select = $('select', this.Settings.field);
        var options = $('option[value="' + value + '"]', select);
        if (options.length == 0) {
            select.append($('<option />').attr('value', value).text(name));
        }
    },

    OpenPopup: function (url) {
        var width = 800;
        var height = 600;
        var left = parseInt((screen.availWidth / 2) - (width / 2));
        var top = parseInt((screen.availHeight / 2) - (height / 2));
        var name = 'lemoonpicker';
        if (this.Settings.isInner) {
            name += '_inner';
        }
        window.open(url, name, 'status=0, toolbar=0, location=0, resizable=1, scrollbars=1, width=' + width + ', height=' + height + ', top=' + top + ', left=' + left).focus();
    }
};

$(document).ready(function () {
  LemoonPicker.init();
});