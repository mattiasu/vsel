;(function ($, window, undefined) {
  'use strict';

  var $doc = $(document),
      Modernizr = window.Modernizr;

  $(document).ready(function() {
    $.fn.foundationAlerts           ? $doc.foundationAlerts() : null;
    $.fn.foundationButtons          ? $doc.foundationButtons() : null;
    $.fn.foundationAccordion        ? $doc.foundationAccordion() : null;
    $.fn.foundationNavigation       ? $doc.foundationNavigation() : null;
    $.fn.foundationTopBar           ? $doc.foundationTopBar() : null;
    $.fn.foundationCustomForms      ? $doc.foundationCustomForms() : null;
    $.fn.foundationMediaQueryViewer ? $doc.foundationMediaQueryViewer() : null;
    $.fn.foundationTabs             ? $doc.foundationTabs({callback : $.foundation.customForms.appendCustomMarkup}) : null;
    $.fn.foundationTooltips         ? $doc.foundationTooltips() : null;
    $.fn.foundationMagellan         ? $doc.foundationMagellan() : null;
    $.fn.foundationClearing         ? $doc.foundationClearing() : null;

    $.fn.placeholder ? $('input, textarea').placeholder() : null;

    var $window = $(window);


    $window.on('scroll', function () {
        var $linkTop = $('#link-top'),
            active = $linkTop.hasClass('active'),
            scrollTop = $window.scrollTop(),
            fold = $window.innerHeight() * .33;

        if (scrollTop >= fold && !active) {
            $linkTop.addClass('active').on('click', function (e) {

                $('html, body').animate({
                    scrollTop: 0
                }, 400, '');

                e.preventDefault();
            }).fadeIn();
        }
        else if (scrollTop <= fold && active) {
            $linkTop.removeClass('active').fadeOut();
        }
    });

    $(window).load(function () {
        $('#slider').orbit();

        $('#contactBtn').click(function () {
            $(this).hide();
            $('#forms').fadeIn(600);
        });

        $('#sendBtn').click(function () {
            var $email = $('#email');
            if (!validateEmail($email.val())) {
                $email.addClass('error');
                return;
            }
            else {
                switchHide($('#loader'), $(this));

                $.ajax({
                    type: "GET",
                    url: "/assets/handlers/contacthandler.ashx",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: {
                        'sender': $('#email').val(),
                        'phone': $('#phone').val(),
                        'message': $('#message').val()
                    },
                    success: function (response) {
                        $('#forms').remove();
                        $ok = $('#ok');
                        $ok.children().last().html(response.message);
                        $ok.fadeIn();
                    },
                    error: function (response) {
                        $('#forms').remove()
                        alert(response.message);
                    }
                });
                return false;
            }
        });

        function validateEmail(email) {
            var re = /\S+@\S+\.\S+/;
            return re.test(email);
        }

        function switchHide(element1, element2) {
            if ($(element1).is(":visible")) {
                $(element1).hide();
                $(element2).show();
            } else {
                $(element2).hide();
                $(element1).show();
            }
        }

        $('input:text, input:password, textarea').focus(function () {
            $this = $(this);
            if ($this.attr('placeholder') != undefined) {
                if ($this[0].value == $this.attr('placeholder')) {
                    $this[0].value = '';
                }
            }
        }).blur(function () {
            $this = $(this);
            if ($this.attr('placeholder') != undefined) {
                if ($.trim($this[0].value) == '') {
                    $this[0].value = $this.attr('placeholder');
                    $this.removeClass('error');
                }
                else if ($this.attr('title') == 'e-post') {
                    if (!validateEmail($this.val())) {
                        $this.addClass('error');
                    }
                    else {
                        $this.removeClass('error');
                    }
                }
            }
        });
    });

  });

  // Hide address bar on mobile devices (except if #hash present, so we don't mess up deep linking).
  if (Modernizr.touch && !window.location.hash) {
    $(window).load(function () {
      setTimeout(function () {
        window.scrollTo(0, 1);
      }, 0);
    });
  }

})(jQuery, this);
