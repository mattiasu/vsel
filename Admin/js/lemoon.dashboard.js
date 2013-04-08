/*
  Resources required for lemoon.dashboard.js:
  - ConfirmDeleteWidget
  - ValidatorRequired
*/

var LemoonDashboard = {

    jQuery: $,

    settings: {
        columns: '.column',
        widgetSelector: '.widget',
        handleSelector: '.widget-head',
        contentSelector: '.widget-content',
        sharedTab: $("#sharedTab").val()
    },

    init: function () {
        this.addWidgetControls();
        this.makeSortable();
        //$(this.settings.columns).disableSelection();
    },

    addWidgetControls: function () {
        var LemoonDashboard = this,
            $ = this.jQuery,
            settings = this.settings;

        $(settings.widgetSelector, $(settings.columns)).each(function () {

            if ($(this).find(".widget-head a").length == 0) {
                if ($(this).attr("id") != '2147483647') {
                    $('<a href="#"><span class="icon-12 delete" /></a>').mousedown(function (e) {
                        /* STOP event bubbling */
                        e.stopPropagation();
                    }).click(function () {
                        if (confirm($("#ConfirmRemoveWidget").val())) {
                            LemoonDashboard.removeWidget($(this).parent().parent().attr("id"));
                            $(this).parents(settings.widgetSelector).animate({
                                opacity: 0
                            }, function () {
                                $(this).wrap('<div/>').parent().slideUp(function () {
                                    $(this).remove();
                                });
                            });
                        }
                        return false;
                    }).appendTo($(settings.handleSelector, this));
                }
                var settingsUI = $.evalJSON($("input", $(this)).val().replace(/'/g, "\""));

                if (settingsUI.length > 0) {
                    $('<a href="#"><span class="icon-12 edit" /></a>').mousedown(function (e) {
                        /* STOP event bubbling */
                        e.stopPropagation();
                    }).toggle(function () {
                        $(this).parents(settings.widgetSelector).find('.edit-box').show();
                        return false;
                    }, function () {
                        $(this).parents(settings.widgetSelector).find('.edit-box').hide();
                        return false;
                    }).appendTo($(settings.handleSelector, this));

                    var edit = $('<div class="edit-box" style="display:none;" />');
                    var inputList = $("<ul />");
                    var label;

                    $(settingsUI).each(function (i) {
                        var container = $('<li class="item" />');
                        if (this.Required) {
                            label = this.DisplayName + " *";
                        } else {
                            label = this.DisplayName;
                        }
                        // Suppress label for hidden.
                        if (this.DataType != "hidden") {
                            container.append($('<label>' + label + '</label>'));
                        }

                        var item = null;

                        if (this.DataType == "string") {
                            item = $('<input />').addClass('string').attr('type', 'text').attr('id', this.Name).attr('name', this.Name);
                            item.val(this.Value);
                        } else if (this.DataType == "password") {
                            item = $('<input />').addClass('string').attr('type', 'password').attr('id', this.Name).attr('name', this.Name);
                        } else if (this.DataType == "bool") {
                            item = $('<input />').addClass('bool').attr('type', 'checkbox').attr('id', this.Name).attr('name', this.Name);
                            if (this.Value == "true" || this.Value === true) {
                                item.attr("checked", "checked");
                            }
                        } else if (this.DataType == "hidden") {
                            item = $('<input />').attr('type', 'hidden').attr('id', this.Name).attr('name', this.Name);
                            if (this.Value) {
                                item.val(this.Value);
                            }
                        } else if (this.DataType == "enum") {
                            item = $('<select />').addClass('enum').attr('id', this.Name).attr('name', this.Name);
                            $(this.EnumValues).each(function () {
                                $(item).append($('<option/>').attr("value", this.Value).text(this.Text));
                            });
                            $(item).find("option[value=" + this.Value + "]").attr("selected", "selected");
                        }
                        if (this.Required) {
                            $(item).attr("title", $("#ValidatorRequired").val().replace('{0}', this.DisplayName));
                        }
                        container.append(item);
                        edit.append(inputList.append(container));
                    });
                    edit.append($('<a href="javascript:void(0);">' + LemoonResources.Save + '</a>').click(function () {
                        LemoonDashboard.SaveSettings($(this).parents("li:first").attr("id"), $(this).parent().find(":input"));
                    }));
                    edit.insertAfter($(settings.handleSelector, this));
                }
                // Remove the hidden input.                
                $("input[type=hidden][id='']", $(this)).remove();

                $('<a href="#" class="collapse"><span class="icon-12 collapse" /></a>').mousedown(function (e) {
                    /* STOP event bubbling */
                    e.stopPropagation();
                }).click(function () {
                    $(this).parents(settings.widgetSelector).toggleClass('collapsed');
                    // Toggle icon.
                    var icon = $(this).find("span");
                    if (icon.hasClass("collapse")) {
                        icon.removeClass("collapse").addClass("expand");
                    } else {
                        icon.removeClass("expand").addClass("collapse");
                    }
                    return false;
                }).prependTo($(settings.handleSelector, this));
            }
        });
    },

    makeSortable: function () {
        var dashboard = this,
            $ = this.jQuery,
            settings = this.settings,
            $sortableItems = (function () {
                var notSortable = '#none,';
                return $('> li:not(' + notSortable + ')', settings.columns);
            })();

        $sortableItems.find(settings.handleSelector).unbind().css({
            cursor: 'move'
        }).mousedown(function (e) {
            $(settings.columns).disableSelection();
            $sortableItems.css({ width: '' });
            $(this).parent().css({
                width: $(this).parent().width() + 'px'
            });
        }).mouseup(function () {
            $(settings.columns).enableSelection();
            if (!$(this).parent().hasClass('dragging')) {
                $(this).parent().css({ width: '' });
            } else {
                $(settings.columns).sortable('disable');
            }
        });

        $(settings.columns).sortable('destroy');

        $(settings.columns).sortable({
            items: $sortableItems,
            connectWith: $(settings.columns),
            handle: settings.handleSelector,
            placeholder: 'widget-placeholder',
            forcePlaceholderSize: true,
            revert: 300,
            delay: 100,
            opacity: 0.8,
            containment: 'document',
            start: function (e, ui) {
                $(ui.helper).addClass('dragging');
            },
            stop: function (e, ui) {
                $(ui.item).css({ width: '' }).removeClass('dragging');
                $(settings.columns).sortable('enable');
                LemoonDashboard.saveLayout(false);
            }
        });
    },

    addWidget: function (name) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: Lemoon.RootUrl() + "admin/api/widget/insert/?name=" + name + "&shared=" + this.settings.sharedTab,
            dataType: "json",
            cache: false,
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(textStatus);
            },
            success: function (data, textStatus) {
                if (data.Status == "error") {
                    alert(data.Message);
                } else {
                    var container = $("<li />").addClass("widget").attr("id", data.ID);
                    var part = $("<div />").addClass("widget-head").append($("<h3 />").text(data.Title).append($("<input />").attr("type", "hidden").val(data.Settings)));
                    container.append(part);
                    part = ($("<div />").addClass("widget-content").html(data.Content));
                    container.append(part);
                    container.prependTo($("#column1"));
                    $("#script").append($("<span />").html(data.Script));
                    LemoonDashboard.addWidgetControls();
                    LemoonDashboard.makeSortable();
                    LemoonDashboard.saveLayout(true);
                }
            }
        });
    },

    removeWidget: function (id) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: Lemoon.RootUrl() + "admin/api/widget/remove?id=" + id,
            dataType: "json",
            cache: false,
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(textStatus);
            },
            success: function (data, textStatus) {
                if (data.Status == "error") {
                    alert(data.Message);
                }
            }
        });
    },

    SaveSettings: function (id, list) {
        var values = '';
        var boolValid = true;

        $(list).each(function () {
            values += "&" + $(this).attr("id") + "=";
            if ($(this).attr("type") == "checkbox") {
                values += $(this).attr("checked");
            } else if ($(this).attr("type") == "select-one") {
                values += $(this).val();
              } else {
                values += encodeURIComponent($(this).val());
            }

            // Check all required fields.
            if ($(this).attr('title') != '' && $(this).val() == '') {
                boolValid = false;
                $(this).parent().find("label:first").addClass("error");
            }
        });
        if (values.length > 0 && boolValid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: Lemoon.RootUrl() + "admin/api/widget/SaveSettings?id=" + id + values,
                dataType: "json",
                cache: false,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                },
                success: function (data, textStatus) {
                    if (data.Status == "error") {
                        alert(data.Message);
                    }
                    // Reload page.
                    location.reload(true);
                }
            });
        }
    },

    saveLayout: function (widgetAdded) {
        var LemoonDashboard = this,
            $ = this.jQuery,
            settings = this.settings;

        var layout = '';

        // Columns
        $(settings.columns).each(function (c) {
            // Rows
            $(settings.widgetSelector, this).each(function (r) {
                layout += $(this).attr("id") + ":" + c + ":" + r + ";";
            });
        });

        if (layout.length > 0) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: Lemoon.RootUrl() + "admin/api/widget/savelayout?layout=" + layout,
                dataType: "json",
                cache: false,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                },
                success: function (data, textStatus) {
                    if (data.Status == "error") {
                        alert(data.Message);
                    }
                    if (widgetAdded) {
                        // Reload page.
                        location.reload(true);
                    }
                }
            });
        }
    }
};
LemoonDashboard.init();
