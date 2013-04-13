<%@ Page Title="" Language="C#" MasterPageFile="~/Lemoon/MasterPages/Vsel.Master" AutoEventWireup="true" CodeBehind="StartPage.aspx.cs" Inherits="vsel.Lemoon.Templates.StartPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EndOfHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
    <div class="twelve columns">
      <div id="slider">
        <% foreach (var image in Content.SliderImages) { %>
            <img src="<%: image.Url() %>" alt="" />
          <%} %>
      </div>
      <hr />
    </div>
  </div>

    <!-- Three-up Content Blocks -->
  
  <div class="row">
  
    <div class="four columns">
      <img src="<%= Content.ColImages.First().Url() %>" />
      <h4><%= (Content.ColPages.First().Value).Title %></h4>
      <p><%= (Content.ColPages.First().Value).Teaser.Ellipsis(250) %>
          <br /><a href="<%= (Content.ColPages.First().Value).Url(false) %>">Läs mer</a>
      </p>
      
    </div>
    
    <div class="four columns">
      <img src="<%= Content.ColImages.Skip(1).First().Url() %>" />
      <h4><%= (Content.ColPages.Skip(1).First().Value).Title %></h4>
      <p><%= (Content.ColPages.Skip(1).First().Value).Teaser.Ellipsis(250) %>
          <br /><a href="<%= (Content.ColPages.Skip(1).First().Value).Url(false) %>">Läs mer</a>
      </p>
    </div>
    <div class="four columns">
      <img src="<%= Content.ColImages.Skip(2).First().Url() %>" />
      <h4><%= (Content.ColPages.Skip(2).First().Value).Title %></h4>
      <p><%= (Content.ColPages.Skip(2).First().Value).Teaser.Ellipsis(250) %>
          <br /><a href="<%= (Content.ColPages.Skip(2).First().Value).Url(false) %>">Läs mer</a>
      </p>
    </div>
    
  </div>
  
  
  <!-- Call to Action Panel -->
  <div class="row">
    <div class="twelve columns">
    
      <div class="panel">
        <h4><%= Content.ContactTitle %></h4>
            
        <div class="row">
          <div class="nine columns">
            <%= Content.ContactText.HtmlSafe(true) %>
            <span id="thanx">
                <%= Content.ContactTextResponse.HtmlSafe(true) %>
            </span>
          </div>
          <div class="three columns">
            <a id="contactBtn" class="radius button right">Kontakta oss</a>
          </div>
        </div>
         <div class="row" id="forms">
              <hr />
             <div class="four columns">
                 <input type="text" id="email" name="e-post" title="e-post" tabindex="1" placeholder="E-post" />
                 <input type="text" id="phone" name="namn" title="telefon" tabindex="2" placeholder="Telefon" />
             </div>
             <div class="eight columns">
                 <textarea tabindex="3" name="meddelande" id="message" title="meddelande" placeholder="Meddelande" ></textarea>
                 <a id="sendBtn" class="radius button right">Skicka</a>
             </div>

         </div>
      </div>
      
    </div>
  </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="EndOfBody" runat="server">
    <script src="/assets/script/spin.js"></script>
    <script type="text/javascript">
        $(window).load(function () {
            $('#slider').orbit();

            $('#contactBtn').click(function () {
                $(this).hide();
                $('#forms').fadeIn(600);
            });

            $('#sendBtn').click(function () {
                $email = $('#email');
                if (!validateEmail($email.val())) {
                    $email.addClass('error');
                    return;
                }
                else {
                    var opts = {
                        lines: 13, // The number of lines to draw
                        length: 20, // The length of each line
                        width: 10, // The line thickness
                        radius: 30, // The radius of the inner circle
                        corners: 1, // Corner roundness (0..1)
                        rotate: 0, // The rotation offset
                        direction: 1, // 1: clockwise, -1: counterclockwise
                        color: '#000', // #rgb or #rrggbb
                        speed: 1, // Rounds per second
                        trail: 60, // Afterglow percentage
                        shadow: false, // Whether to render a shadow
                        hwaccel: false, // Whether to use hardware acceleration
                        className: 'spinner', // The CSS class to assign to the spinner
                        zIndex: 2e9, // The z-index (defaults to 2000000000)
                        top: 'auto', // Top position relative to parent in px
                        left: 'auto' // Left position relative to parent in px
                    };
                    var target = $('#forms');
                    var spinner = new Spinner(opts).spin(target);
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
                            console.info('ok');
                            spinner.stop();

                            //$('select', '#lbDownload').selectBox('destroy');
                            //$("#lbDownload").find('.content').empty();
                            //$("#downloadTemplate").tmpl(response).appendTo($("#lbDownload .content"));
                            //$("input:checkbox[class!=nojs]", "#lbDownload").uniform();
                            //$('select', '#lbDownload').selectBox();

                            //if ($("#favorites").has("#" + response.Guid).length) {
                            //    $("#pFavourite").addClass("available");
                            //}
                        },
                        error: function (response) {
                            console.error('fail');
                        }
                    });
                    return false;
                }
            });

            function validateEmail(email) {
                var re = /\S+@\S+\.\S+/;
                return re.test(email);
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
                    else if($this.attr('title') == 'e-post') {
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
  </script>
</asp:Content>
