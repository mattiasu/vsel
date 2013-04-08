var Lemoon = {

    /* ------------------------------------------------------------   
    - Initializes main functionality
    - Watermark on search field
    - Preview site
    - Menu slide down
    ------------------------------------------------------------ */
    init: function () {
        // search form watermark
        $("#q").watermark(LemoonResources.Search + "...");

        // preview site
        $("#viewsite").click(
      function () {
          if (event.ctrlKey) {
              window.location.href = Lemoon.AdminUrl() + 'content/preview.aspx';
              return false;
          } else {
              return true;
          }
      }
    );

        // menu
        $('#menu .menu ul li:last-child').addClass('last');
        $('#menu .menu').click(
            function () {
                if ($('ul', this).is(':hidden')) {
                    $('a', this).addClass('selected');
                    $('ul', this).slideDown(100);
                } else {
                    $('ul', this).slideUp(100);
                }
            }
        ).mouseleave(
            function () {
                obj = this;
                $('ul', this).slideUp(100, function () { $('>a', obj).removeClass('selected'); });
            }
        );

        // mac-hack 
        var ua = navigator.userAgent.toLowerCase();
        if (ua.indexOf('mac') != -1 && ua.indexOf('firefox') != -1) {
            $('#sub-menu ul').css("top", "22px");
        }
    },

    /* ------------------------------------------------------------   
    - Shows a message.
    - message: Message to show.
    - type: info, error
    - delay: Milliseconds to display the message. Set to 0 to always display message.
    ------------------------------------------------------------ */
    ShowMessage: function (message, type, delay) {
        $('#message').remove();
        var container = $('<div />').attr('id', 'message').css('top', $(window).scrollTop());
        container.append($('<span></span>').addClass('icon-48 ' + type));
        container.append($('<p />').html(message));
        container.append($('<a />').attr('class', 'messagelink').attr('href', 'javascript:void(0);').text(LemoonResources.CloseMessage).click(function () {
            Lemoon.HideMessage();
        }));

        $('body').append(container);
        container.slideDown(300);

        container.attr('class', type);

        if (delay != 0) {
            window.setTimeout(Lemoon.HideMessage, delay);
        }
    },

    /* ------------------------------------------------------------   
    - Hides a displayed message.
    ------------------------------------------------------------ */
    HideMessage: function () {
        var container = $('#message');
        if (container.length > 0) {
            container.slideUp("400", function () { $(this).remove(); });
        }
    },

    /* ------------------------------------------------------------   
    - Gets the offset position of a specific object.
    - var pos = Lemoon.FindPos($('#myelement'));
    - var left = pos[0];
    - var top = pos[1];
    ------------------------------------------------------------ */
    FindPos: function (element) {
        var left = 0
        var top = 0;
        if (element.offsetParent() != null) {
            left = element.offset().left;
            top = element.offset().top;
        }

        return [left, top];
    },

    GetBrowser: function () {
        var browser = navigator.userAgent.toLowerCase();
        var browserCode;

        if (browser.indexOf('msie') != -1) {
            return 'ie';
        }
        else if (browser.indexOf('chrome') != -1) {
            return 'chrome';
        }
        else if (browser.indexOf('firefox') != -1) {
            return 'firefox';
        }
        else if (browser.indexOf('safari') != -1) {
            return 'safari'
        }
    },

    /* ------------------------------------------------------------   
    - Deletes a specific content
    - contentID: ID of the content to delete
    - returnUrl: Url to redirect to after the delete.
    ------------------------------------------------------------ */
    DeleteContent: function (contentID, returnUrl) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: Lemoon.RootUrl() + "admin/api/content/delete?contentID=" + contentID,
            dataType: "json",
            cache: false,
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(textStatus);
            },
            success: function (data, textStatus) {
                if (data.Status == "error") {
                    alert(data.Message);
                } else {
                    location.href = returnUrl;
                }
            }
        });
    },

    CreateCookie: function (name, value, days) {
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            var expires = "; expires=" + date.toGMTString();
        }
        else var expires = "";
        document.cookie = name + "=" + value + expires + "; path=/";
    },

    ReadCookie: function (name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    },

    EraseCookie: function (name) {
        createCookie(name, "", -1);
    },

    /* ------------------------------------------------------------   
    - Gets the url to the admin section
    ------------------------------------------------------------ */
    RootUrl: function () {
        return location.href.substring(0, location.href.indexOf('/admin/')) + '/';
    },
    AdminUrl: function () {
        return Lemoon.RootUrl() + 'admin/';
    },
    ThemeUrl: function () {
        return $("input[name='lemoon.themeurl']").val();
    }
};

$(document).ready(function () {
    Lemoon.init();
});