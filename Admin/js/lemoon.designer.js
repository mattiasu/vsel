/// <reference path="jquery-1.4.2.js"/>

var _dropIndex = 1;
var _index = 1;

var LemoonDesigner = {
    /* ------------------------------------------------------------   
    - Initializes main functionallity.
    ------------------------------------------------------------ */
    init: function () {

        // Click to add a control to stage.
        $('#formfields li').click(function () {
            _dropIndex = 1;
            LemoonDesigner.AddField($(this), $('#stage'));
        });

        // Make stage sortable.
        $('#stage').sortable({
            placeholder: 'placeholder',
            delay: 100,
            axis: 'y'
        }).disableSelection();

        // Opens the properties tab and sets properties from hidden fields.
        $('#stage li').live('click', function () {
            $('#stage li').removeClass('selected');
            $(this).addClass('selected');
            $('#propertiestab').removeAttr('disabled');
            LemoonDesigner.SetProperties($(this));
            LemoonDesigner.ShowTab('properties', $('#propertiestab'));
        });

        // Removes a field.
        $('.tools .remove').live('click', function () {
            if (confirm($('input[name="lemoon.resources.ConfirmRemoveField"]').val())) {
                $(this).parents('li').remove();
                LemoonDesigner.RemoveFieldSelection();
            }
            return false;
        });

        // Duplicates a field.
        $('.tools .add').live('click', function () {
            var field = $(this).parents('li');
            var newField = field.clone();

            var newID = LemoonDesigner.GetUniqueID();
            var oldID = newField.attr('id');
            var currentIndex = field.find('input[name=fieldindex]').val();
            var oldPropertyName = $('#' + oldID + '_id').val();
            var newPropertyName = oldPropertyName + _index;

            var reNewID = new RegExp(oldID, "g"); // global replace.
            var rePropName1 = new RegExp('value="' + oldPropertyName + '"', "g");
            var rePropName2 = new RegExp('value=' + oldPropertyName, "g");
            var reUpdate1 = new RegExp('id="' + oldPropertyName + '_update"', "g");
            var reUpdate2 = new RegExp('id=' + oldPropertyName + '_update', "g");
            var reFieldIndex1 = new RegExp('name="fieldindex" value="' + currentIndex + '"', "g");
            var reFieldIndex2 = new RegExp('value=' + currentIndex + ' type=hidden name=fieldindex', "g");
            var reScript = new RegExp("#" + oldPropertyName + "_update", "g");


            // Replaces all old ID with the new on the duplicated html content.
            var html = newField.html();

            html = html.replace(reUpdate1, 'id="' + newPropertyName + '_update"');
            html = html.replace(reUpdate2, 'id=' + newPropertyName + '_update');
            html = html.replace(rePropName1, 'value="' + newPropertyName + '"');
            html = html.replace(rePropName2, 'value=' + newPropertyName);
            html = html.replace(reNewID, newID);
            html = html.replace(reScript, "#" + newPropertyName + "_update");
            html = html.replace(reFieldIndex1, 'name="fieldindex" value="' + _index + '"');
            html = html.replace(reFieldIndex2, 'value=' + _index + ' type=hidden name=fieldindex');

            newField.html(html);
            newField.removeClass('selected').insertAfter(field);

            // Sets the new ID on the duplicated LI tag.    
            newField.attr('id', newID)
            $('#' + newID + '_id').val(newPropertyName);

            LemoonDesigner.RemoveFieldSelection();

            return false;
        });

        // Register events for default properties.
        $('#field_id').keyup(function () {
            $('#' + $('#stage li.selected').attr('id') + '_id').val($(this).val());
        });
        $('#field_label').keyup(function () {
            $('#' + $('#stage li.selected').attr('id') + '_label').val($(this).val());
            $('#stage li.selected label:first').text($(this).val());
        });
        $('#field_showfordisplay').click(function () {
            $('#' + $('#stage li.selected').attr('id') + '_showfordisplay').val($(this).is(':checked') ? '1' : '0');
        });
        $('#field_showforedit').click(function () {
            $('#' + $('#stage li.selected').attr('id') + '_showforedit').val($(this).is(':checked') ? '1' : '0');
        });
        $('#field_description').keyup(function () {
            $('#' + $('#stage li.selected').attr('id') + '_description').val($(this).val());
            $('#stage li.selected .description').text($(this).val());
        });
        $('#field_cssclass').keyup(function () {
            $('#' + $('#stage li.selected').attr('id') + '_cssclass').val($(this).val());
        });
        $('#field_alignment').change(function () {
            $('#' + $('#stage li.selected').attr('id') + '_alignment').val($(this).val());
            $('#stage li.selected').attr('class', 'selected'); // Removes all other classes.
            $('#stage li.selected').addClass('form' + $(this).val());
            if ($('#field_layout').val() != '') { // adds the class from field layout if set.
                $('#stage li.selected').addClass($('#field_layout').val());
            }
        });
        $('#field_layout').change(function () {
            $('#' + $('#stage li.selected').attr('id') + '_layout').val($(this).val());
            $('#stage li.selected').attr('class', 'selected'); // Removes all other classes.
            $('#stage li.selected').addClass($(this).val());
            if ($('#field_alignment').val() != '') { // adds the class from field alignment if set.
                $('#stage li.selected').addClass('form' + $('#field_alignment').val());
            }
        });
        $('#field_exporttitle').keyup(function () {
            $('#' + $('#stage li.selected').attr('id') + '_exporttitle').val($(this).val());
        });
        $('#setting_alignment').change(function () {
            $('#stage').attr('class', $(this).val());
        });
    },

    /* ------------------------------------------------------------   
    - Gets an unique ID of the field LI.
    ------------------------------------------------------------ */
    GetUniqueID: function () {
        while (document.getElementById('field_' + _index) != null) {
            _index++;
        }
        return String('field_' + _index);
    },

    /* ------------------------------------------------------------   
    - Adds a field to the stage section.
    - $item: The LI tag that contains the control that has been 
    -        added to stage
    - $parent: Set to UL#stage if adding a control by click. Set to 
    -          null if adding with drag & drop.
    ------------------------------------------------------------ */
    AddField: function ($item, $parent) {
        var fieldID = $item.attr('id');

        // If clicked on a control to add it -> Clone and move a field if $parent is set.
        if ($parent != null) {
            $item = $item.clone();
            $item.appendTo($parent);
        }

        $item.removeAttr('style');
        $item.removeAttr('class');
        $item.html('<div class="smallprogress"></div>');

        // Loads the control information.
        var control = LemoonDesigner.GetFieldProperties(fieldID);
        if (control == null) {
            $item.html('Could not load properties from field control ' + fieldID.replace(/_/g, '.') + '.');
            return;
        }

        // Adds the default layout css from the DesignFieldAttribute.
        if (control.layoutCss != '') {
            $item.addClass(control.layoutCss);
        }

        // Creates a unique identifier.
        $item.attr('id', 'field_' + _index);
        _index++;

        // Adds the HTML, hidden fields and script to the LI tag.
        $item.html(control.designerHtml + '<div class="clearLabel"></div>');
    },

    /* ------------------------------------------------------------   
    - Sets the field values in the properties tab.
    - $item: The selected LI tag in the stage section.
    ------------------------------------------------------------ */
    SetProperties: function ($item) {
        $('#field_id').val($item.find('#' + $item.attr('id') + '_id').val());
        $('#field_label').val(decodeURI($item.find('#' + $item.attr('id') + '_label').val()));
        $('#field_exporttitle').val(decodeURI($item.find('#' + $item.attr('id') + '_exporttitle').val()));

        var checkedValue = $item.find('#' + $item.attr('id') + '_showforedit').val();
        if (checkedValue == '1' || checkedValue == '') {
            $('#field_showforedit').attr('checked', 'checked');
        }
        else {
            $('#field_showforedit').removeAttr('checked');
        }

        var checkedValue = $item.find('#' + $item.attr('id') + '_showfordisplay').val();
        if (checkedValue == '1' || checkedValue == '') {
            $('#field_showfordisplay').attr('checked', 'checked');
        }
        else {
            $('#field_showfordisplay').removeAttr('checked');
        }

        $('#field_description').val(decodeURI($item.find('#' + $item.attr('id') + '_description').val()));
        $('#field_cssclass').val($item.find('#' + $item.attr('id') + '_cssclass').val());
        var alignment = $item.find('#' + $item.attr('id') + '_alignment').val();
        if (alignment != '') {
            alignment = alignment.replace('form', '');
        }
        $('#field_alignment').val(alignment);

        // Add items to the layout SELECT box from the LayoutCss property from the DesignField attribute on the field control.
        var layoutItems = $item.find('#' + $item.attr('id') + '_layoutItems').val();
        if (layoutItems != '') {
            $('#field_layout').parent().parent().show();
            var arrItems = layoutItems.split(',');
            $('#field_layout').text('');
            for (var index = 0; index != arrItems.length; index++) {
                if (arrItems[index] != '') {
                    arrValues = arrItems[index].split(':');
                    $('#field_layout').append($("<option></option>").attr("value", arrValues[0]).text(arrValues[1]));
                }
            }
            $('#field_layout').val($item.find('#' + $item.attr('id') + '_layout').val());
        }
        else {
            // Hides the layout select if no layout items found.
            $('#field_layout').parent().parent().hide();
        }

        // Adds custom property fields.
        LemoonDesigner.AddCustomProperties($item);
    },

    /* ------------------------------------------------------------   
    - Sets the field values for the custom properties in the properties tab.
    - $item: The selected LI tag in the stage section.
    ------------------------------------------------------------ */
    AddCustomProperties: function ($item) {
        // Gets the JSON value from the hidden field.
        var controlAsString = $item.find('#' + $item.attr('id') + '_json').val();
        var html = '';
        var registerSortableList = false;

        if (controlAsString != '') {

            // Parses the escaped JSON value in the hidden field to a javascript object. Replaces characters that the decode not converted.
            var decodedControl = decodeURI(controlAsString).replace(/%3a/g, ':').replace(/%2c/g, ',').replace(/%24/g, '$').replace(/%3b/g, ';').replace(/%3d/g, '=');
            var encoded = $.toJSON(decodedControl);
            var control = eval('(' + $.evalJSON(encoded) + ')');

            if (control.properties.length != 0) {

                // Iterates through all custom properties.
                for (var index = 0; index != control.properties.length; index++) {

                    // If the property have an Action script a function call is created [LI-id]_[property-name]_UpdateField([reference-to-hidden-field], [reference-to-selected-field-control]);
                    var controlEvent = '';
                    if (control.properties[index].Action != '') {
                        controlEvent = $item.attr('id') + '_' + control.properties[index].Name + '_UpdateField($(\'#' + $item.attr('id') + '_' + control.properties[index].Name + '\'), $(\'#stage li.selected .fieldcontrol\'));';
                    }

                    switch (control.properties[index].Type) {

                        // Checkbox                                                                                                                                                                                                                                     
                        case 'checkbox':
                            controlEvent = "$('#" + $item.attr('id') + "_" + control.properties[index].Name + "').val($(this).is(':checked') ? '1' : '0');" + controlEvent;
                            var checkedValue = $('#' + $item.attr('id') + "_" + control.properties[index].Name).val() == '1' ? ' checked="checked"' : '';

                            html += '<li>';
                            html += '<div>';
                            html += '<input class="checkbox" type="checkbox" onclick="' + controlEvent + '" id="customfield_' + control.properties[index].Name + '"' + checkedValue + ' />';
                            html += '<label for="customfield_' + control.properties[index].Name + '">' + control.properties[index].Name + '</label>';
                            html += '</div>';
                            html += '</li>';
                            break;

                        // Textbox                                                                                                                                                                                                                                     
                        case 'textbox':
                            controlEvent = "$('#" + $item.attr('id') + "_" + control.properties[index].Name + "').val($(this).val());" + controlEvent;

                            var re = new RegExp('"', 'g'); // global replace.
                            var htmlValue = $('#' + $item.attr('id') + "_" + control.properties[index].Name).val().replace(re, '&quot;');

                            html += '<li>';
                            html += '<label>' + control.properties[index].Name + '</label>';
                            html += '<div><input type="text" id="customfield_' + control.properties[index].Name + '" onkeyup="' + controlEvent + '" value="' + htmlValue + '" /></div>';
                            html += '</li>';
                            break;

                        // Listbox                                                                                                                                                                         
                        case 'select':
                        case 'selectmany':
                            html += '<li>';
                            html += '<label>' + control.properties[index].Name + '</label>';
                            html += '<div>';
                            html += '<ul class="selectmany" onclick="LemoonDesigner.SaveList($(this), $(\'#' + $item.attr('id') + '_' + control.properties[index].Name + '\'));' + controlEvent + '" onkeyup="LemoonDesigner.SaveList($(this), $(\'#' + $item.attr('id') + '_' + control.properties[index].Name + '\'));' + controlEvent + '">';

                            html += LemoonDesigner.LoadList($('#' + $item.attr('id') + '_' + control.properties[index].Name), control.properties[index].Type);

                            html += '</ul>'
                            html += '</div>';
                            html += '</li>';

                            registerSortableList = true;
                            break;

                        case 'html':
                            controlEvent = "$('#" + $item.attr('id') + "_" + control.properties[index].Name + "').val($(this).val());" + controlEvent;
                            var htmlValue = ''
                            try {
                                htmlValue = decodeURI($('#' + $item.attr('id') + "_" + control.properties[index].Name).val());
                            }
                            catch (ex) {
                                htmlValue = unescape($('#' + $item.attr('id') + "_" + control.properties[index].Name).val());
                            }
                            html += '<li>';
                            //html += '<div><a id="editHtml" href="javascript:void(0);" alt="' + $item.attr('id') + "_" + control.properties[index].Name + '" onclick="LemoonPopup.ToggleDialog($(\'#' + $('input[name=lemoon.popupid]').val() + '\'), true);">' + $('input[name=lemoon.resources.EditHtmlText]').val() + '</a></div>';
                            html += '<div><a id="editHtml" href="javascript:void(0);" alt="' + $item.attr('id') + "_" + control.properties[index].Name + '" onclick="$(\'.htmleditor\').show();$(\'.htmleditor\');">' + $('input[name="lemoon.resources.EditHtmlText"]').val() + '</a></div>';
                            html += '</li>';

                            // Reset the editor.
                            tinyMCE.activeEditor.setContent(htmlValue);
                            //tinyMCE.activeEditor.contentDocument.getElementById('tinymce').innerHTML = htmlValue;
                            break;
                    }
                }
            }
        }
        $('#customproperties').html(html);

        if (registerSortableList) {
            $('.selectmany').sortable({
                placeholder: 'placeholder',
                handle: '.listsort',
                delay: 100,
                axis: 'y'
            });

            $('.selectmany .listname').watermark("Name");
            $('.selectmany .listvalue').watermark("Value");
        }

    },

    /* ------------------------------------------------------------   
    - Saves the items from a list designer (from property tab) to a hidden field
    - as a escaped JSON string.
    - $sender: UL list that holds all list name, value and selected state.
    - $control: Hidden control that the state is saved to.
    ------------------------------------------------------------ */
    SaveHtmlField: function () {
        var html = tinyMCE.activeEditor.getContent(); // Get content from editor.
        tinyMCE.activeEditor.setContent(''); // Clears editor.

        // Updates the hidden input with the encoded html.
        $('#' + $('#editHtml').attr('alt')).val(encodeURI(html));

        // Sets the HTML to the selected field control.
        $('#stage li.selected .fieldcontrol').html(html);

        //LemoonPopup.ToggleDialog($('#' + $('input[name=lemoon.popupid]').val()), false);
        $('.htmleditor').hide();
    },

    /* ------------------------------------------------------------   
    - Saves the items from a list designer (from property tab) to a hidden field
    - as a escaped JSON string.
    - $sender: UL list that holds all list name, value and selected state.
    - $control: Hidden control that the state is saved to.
    ------------------------------------------------------------ */
    SaveList: function ($sender, $control) {
        var values = new Array();
        $sender.find('li').each(function (i) {
            var input = $(this).find('input');
            input.eq(1).watermark("Name");
            input.eq(2).watermark("Value");
            var item = new Object();
            item.Name = input.eq(1).val();
            item.Value = input.eq(2).val();
            item.Selected = input.eq(0).is(':checked') ? '1' : '0';
            values[i] = item;
        });
        $control.val(encodeURI($.toJSON(values)));
    },

    /* ------------------------------------------------------------   
    - Loads the value from the hidden field and adds the items to 
    - the list designer.
    - $control: Hidden control that the state is stored in.
    - Return: Returns the markup for the items in the list.
    ------------------------------------------------------------ */
    LoadList: function ($control, listType) {
        var html = '';
        if ($control.val() == '') {
            html += LemoonDesigner.CreateListRow('', '', '1', $control.attr('id'), listType == 'select' ? 'radio' : 'checkbox');
        }
        else {
            //var encoded = $.toJSON(decodeURI($control.val()));
            //var items = eval('(' + $.evalJSON(encoded) + ')');
            var encoded = decodeURI($control.val());
            var items = $.evalJSON(encoded);
            $(items).each(function (i) {
                html += LemoonDesigner.CreateListRow(items[i].Name, items[i].Value, items[i].Selected, $control.attr('id'), listType == 'select' ? 'radio' : 'checkbox');
            });
        }
        return html;
    },

    /* ------------------------------------------------------------   
    - Creates a list row in the list designer.
    - name: Text value
    - value: Value
    - selected: If the list item is selected.
    - showRemove: If the remove icon is shown.
    - controlID: The ID of the hidden control that the state is stored in.
    - type: The type of select, either radio or checkbox. (eg. select or selectmany) 
    - Return: Returns the markup for the list item.
    ------------------------------------------------------------ */
    CreateListRow: function (name, value, selected, controlID, type) {
        //REVIEW: Add, Remove och Selected checkboxen skall uppdatera kontrollens data med Action skriptet.
        var checked = selected == '1' ? ' checked="checked"' : '';

        var re = new RegExp('"', 'g'); // global replace.
        name = name.replace(re, '&quot;');
        value = value.replace(re, '&quot;');

        var html = '<li>';
        html += '<input name="' + controlID + '_sel" class="checkbox" type="' + type + '"' + checked + ' />';
        html += '<input class="listname" type="text" value="' + name + '" tabindex="1" />';
        html += '<input class="listvalue" type="text" value="' + value + '" tabindex="1" />';
        html += '<a class="listsort" href="javascript:void(0);"><span class="icon-12 sort"></span></a>';
        html += '<a class="listremove" href="javascript:void(0);" onclick="LemoonDesigner.RemoveListRow($(this), \'' + controlID + '\');"><span class="icon-12 red remove"></span></a>';
        html += '<a class="listadd" href="javascript:void(0);" onclick="LemoonDesigner.AddListRow($(this), \'' + controlID + '\');"><span class="icon-12 green add"></span></a>';
        html += '</li>'
        return html;
    },

    /* ------------------------------------------------------------   
    - Adds a list row to the list designer.
    - $sender: The clicked icon.
    - controlID: The ID of the hidden control that the state is stored in.
    ------------------------------------------------------------ */
    AddListRow: function ($sender, controlID) {
        var html = LemoonDesigner.CreateListRow('', '', '', controlID, $sender.parent().children().eq(0).attr('type'));
        $sender.parent().after($(html));
        LemoonDesigner.SaveList($sender.parent().parent(), $('#' + controlID));
    },

    /* ------------------------------------------------------------   
    - Removes a list row from the list designer.
    - $sender: The clicked icon.
    - controlID: The ID of the hidden control that the state is stored in.
    ------------------------------------------------------------ */
    RemoveListRow: function ($sender, controlID) {
        var $ul = $sender.parent().parent();
        if ($ul.find('li').length == 1) {
            return;
        }
        $sender.parent().remove();
        LemoonDesigner.SaveList($ul, $('#' + controlID));
    },

    /* ------------------------------------------------------------   
    - Executes an AJAX call to GetFieldProperties and returns a
    - JSON object with the properties for the control.
    - fieldID: The full name of the field control that should be 
    -          loaded. Ex: 'Mindroute.Lemoon.Web.UI.WebControls.TextField'.
    ------------------------------------------------------------ */
    GetFieldProperties: function (fieldID) {
        var returnValue = null;
        $.ajax({
            type: 'POST',
            async: false,
            contentType: 'application/json; charset=utf-8',
            url: Lemoon.RootUrl() + 'admin/api/content/GetFieldProperties/?fieldTypeID=' + fieldID + '&index=' + _index,
            dataType: "json",
            cache: false,
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                var data = new Object();
                data.html = 'An exception occurred when loading control.<br />Status: ' + XMLHttpRequest.status + ' ' + XMLHttpRequest.statusText;
                data.properties = new Array();
                returnValue = data;
            },
            success: function (data, textStatus) {
                returnValue = data;
            }
        });
        return returnValue;
    },

    /* ------------------------------------------------------------   
    - Hides all tabs and display one specific.
    - tabid: ID of the tab to show.
    - sender: The clicked anchor in the tab list.
    ------------------------------------------------------------ */
    ShowTab: function (tabid, sender) {
        //    if (tabid == 'properties' && $('#stage li').hasClass('selected') == false) {
        //      return;
        //    }
        $("#aside .tab").hide();
        $("#" + tabid).show();
        $("#aside .tabs").find("li").attr("class", "");
        $(sender).parent().attr("class", "selected");
    },

    /* ------------------------------------------------------------   
    - Deselects the selected field and switches tab to the Field-tab.
    ------------------------------------------------------------ */
    RemoveFieldSelection: function () {
        LemoonDesigner.ShowTab('formfields', $('#fieldtab'));
        $('#stage li.selected').removeClass('selected');
        $('#propertiestab').attr('disabled', 'disabled');
    },

    /* ------------------------------------------------------------   
    - Sets the required marker on the selected field.
    ------------------------------------------------------------ */
    SetRequiredState: function (isRequired) {
        if (isRequired) {
            $('#stage li.selected .required').text('*');
        } else {
            $('#stage li.selected .required').text('');
        }
    },

    /* ------------------------------------------------------------   
    - Submits the form and saves the content type.
    - JQuery Form Plugin: http://jquery.malsup.com/form/
    ------------------------------------------------------------ */
    SubmitForm: function () {

        // Reset the value in the text editor for HtmlField to avoid potential dangerous requests.
        try {
            tinyMCE.activeEditor.setContent('');
            $('#' + $('input[name="lemoon.htmleditorid"]').val()).html(''); // This value is stored in design.aspx.cs.
        } catch (ex) {
            alert(ex);
        }

        var options = {
            url: Lemoon.RootUrl() + 'admin/api/content/savecontenttype',
            beforeSubmit: LemoonDesigner.BeforeSubmit,  // pre-submit callback
            success: LemoonDesigner.SubmitSuccess, // post-submit callback 
            error: LemoonDesigner.SubmitError // error handling
        };
        $('#aspnetForm').ajaxSubmit(options);
        return false;
    },

    /* ------------------------------------------------------------   
    - Callback function to be invoked before the form is submitted.
    - formData: The form data in array format. [ { name: 'textbox1', value: 'val1' }, { ... } ]
    - jqForm: The jQuery object for the form.
    - options: The Options Object passed into ajaxForm/ajaxSubmit.
    ------------------------------------------------------------ */
    BeforeSubmit: function (formData, jqForm, options) {
        //var queryString = $.param(formData);
        //alert('About to submit: \n\n' + queryString);

        $('#progress').show();
        return true; // Return true to continue with submit.
    },

    /* ------------------------------------------------------------   
    - Callback function to be invoked after the form has been submitted.
    - responseText: Json returned from ContentController.SaveContentType().
    - statusText: Returns "success" if the call was successful.
    ------------------------------------------------------------ */
    SubmitSuccess: function (responseText, statusText) {
        var encoded = $.toJSON(responseText);
        var control = $.evalJSON(encoded);
        if (control.Status == "error") {
            alert(control.Message);
        }
        else {
            //alert(responseText);
        }

        if (control.SystemName != '') {
            $('input[name=setting_name]').val(control.SystemName);
        }

        $('#progress').hide();
    },

    SubmitError: function (XMLHttpRequest, textStatus, errorThrown) {
        $('#progress').hide();
        alert(XMLHttpRequest.statusText);
    }
};

$(document).ready(function() {
  LemoonDesigner.init();
});
