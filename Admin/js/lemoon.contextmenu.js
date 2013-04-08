var LemoonContextMenu = {

    /* ------------------------------------------------------------   
    - Initializes main functionality
    ------------------------------------------------------------ */
    init: function (type) {
        // Close context menu.
        $(document).bind('click', function (e) {
            $('#contextmenu').hide();
            return true;
        });

        var searchRoot = '.tree li > a:not(.site)';
        if ($(searchRoot).length == 0 || type == 'file' || type == 'children') {
            searchRoot = '.ctmenu > a';
        }

        // Open context menu
        $(searchRoot).live("contextmenu", function (e) {
            // Displays the context menu container.
            $('#contextmenu').show().css('top', e.pageY).css('left', e.pageX);

            // Adds an image with a loading icon in the container.
            $('#contextmenu ul').empty().append($('<img />').attr('src', Lemoon.ThemeUrl() + 'img/loading.gif').attr('alt', ''));

            // Requests the menus from the server.
            LemoonContextMenu.LoadMenu($(this).data('id'), $(this).find('a').hasClass('site'), type);
            e.preventDefault();
            e.cancelBubble = false;
            e.stopPropagation()
            return false;
        });
    },

    LoadMenu: function (contentID, isSite, type) {
        var rooturl = Lemoon.RootUrl();

        var url = rooturl + 'admin/api/content/GetMenu?id=' + contentID + '&languageid=' + LemoonProperties.LanguageID + '&issite=' + isSite + '&menuType=' + type;
        //var type = $("input[name=lemoon.contextmenu.type]").val();

        if (type == 'folder') {
            url = rooturl + 'admin/api/file/GetMenu?id=' + contentID + '&languageid=' + LemoonProperties.LanguageID + '&issite=' + isSite;
        } else if (type == 'file') {
            url = rooturl + 'admin/api/file/GetMenuFile?id=' + contentID + '&languageid=' + LemoonProperties.LanguageID;
        }

        $.ajax({
            url: url,
            type: 'POST',
            cache: false,
            processData: false,
            dataType: 'json',
            success: function (response, textStatus) {
                $('#contextmenu ul').empty();
                if (response != null) {
                    if (response.length > 0) {
                        for (i = 0; i <= response.length - 1; i++) {
                            LemoonContextMenu.AddMenuItem(response[i], $('#contextmenu ul'));
                        }
                        if (($('#contextmenu').offset().top + $('#contextmenu ul').outerHeight()) > ($(window).height() + $(window).scrollTop())) {
                            $('#contextmenu').show().css('top', $(window).height() - $('#contextmenu ul').outerHeight() + $(window).scrollTop());
                        }

                    }
                }
            },
            error: function (xhr, textStatus, errorThrown) {
                alert('Load context menu failed.');
                $('#contextmenu').hide();
            }
        });

    },

    AddMenuItem: function (item, parent) {
        var anchor = $("<a/>").text(item.Text);
        if (item.HRef != null) {
            $(anchor).attr("href", item.HRef);
        }
        if (item.OnClick != '') {
            //$(anchor).attr('onclick', item.OnClick);
            $(anchor).bind('click', function () {
                eval(item.OnClick);
            });
        }
        if (!item.Enabled) {
            $(anchor).attr('disabled', 'disabled').attr('href', 'javascript:void(0)');

        }
        $("<li/>").append(anchor).appendTo(parent);
    }
};
