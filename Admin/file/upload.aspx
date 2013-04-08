<%@ page language="C#" autoeventwireup="true" codebehind="upload.aspx.cs" inherits="Mindroute.Lemoon.Admin._File.FileUpload" masterpagefile="~/admin/master/main.master" %>

<asp:content contentplaceholderid="head" runat="server">
<link type="text/css" href="../js/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css" rel="stylesheet" />
<link type="text/css" href="../theme/default/plupload/css/plupload.queue.css" rel="stylesheet" />
<script type="text/javascript" src="../js/plupload/plupload.full.js"></script>
<script type="text/javascript" src="../js/plupload/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<% if (System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName == "sv") { %><script type="text/javascript" src="../js/plupload/i18n/sv.js"></script><% } %>
<script type="text/javascript">
    $(function() {
      $("#uploader").pluploadQueue({
        runtimes: 'html5,html4',
        url: '<%= ScriptUrl %>',
        max_file_size: '<%= MaxFileSize %>',
        unique_names: false,
        multipart: true,
        preinit: function (up) {
          $('.plupload_start').hide();
        }
      });

      $('#<%=save.ClientID %>').removeAttr('disabled');
      $('#<%=cancel.ClientID %>').removeAttr('disabled');
    });

    function ExecuteUpload() {
      var uploader = $('#uploader').pluploadQueue();
      <% if (destination.Visible) { %>
      var folderRef =  $('#<%=destination.ClientID %>_h').val();
      if (folderRef == '') {
        alert('<%= string.Format(Mindroute.Core.Properties.Resources.Validation_Required, Mindroute.Lemoon.Properties.Resources.TargetFolder) %>');
        return;
      } else {
        var parentID = folderRef.split('/')[0] || 0;
        var languageID = folderRef.split('/')[1];
        uploader.settings.url = '<%=ScriptUrl %>?parentID=' + parentID + '&languageID=' + languageID;
      }
      <% } %>

      if (uploader.total.uploaded == 0) {
        if (uploader.files.length > 0) {

          var checked = '0';
          if ($('#<%=uncompress.ClientID %>_f').attr('checked')) {
            checked = '1';
          }
          var auth = "<% = AuthenticationCookie  %>";
          uploader.settings.multipart_params = { 'description': encodeURIComponent($('#<%=description.ClientID %>_f').val()), 'checked': checked, 'AuthenticationToken': auth, 'authenticity_token': auth };

          $('#<%=save.ClientID %>').attr('disabled', 'true');
          $('#<%=cancel.ClientID %>').attr('disabled', 'true');

          uploader.bind('Error', function (upr, error) {
            alert("An error occurred when uploading a file.\n\nError: " + error.code + "\nMessage: " + error.message + (error.file ? "\nFile: " + error.file.name : ""));
            LoadUploader();
          });

          uploader.bind('UploadProgress', function () {
            if (uploader.total.uploaded == uploader.files.length) {
              window.location.href = '<%=cancel.HRef %>';
            }
          });

          uploader.start();
        } else {
          alert('<%=Mindroute.Lemoon.Properties.Resources.SelectAFileBeforeUpload %>');
        }
      }
    }
  </script>
</asp:content>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:filemenu id="fileMenu" runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server">
    <lemoon:folderfield id="destination" runat="server" label="<%$ LemoonResources: TargetFolder%>" visible="false" required="true" />
    <div id="flashupload" runat="server" class="field">
      <label id="selectFile" runat="server" />
      <div id="uploader"></div>
      <div class="info">
        <asp:localize runat="server" text="<%$ LemoonResources: UploadFileHelpText%>" />
      </div>
    </div>
    <lemoon:uploadfield id="uploadsimple" runat="server" label="<%$ LemoonResources: UploadFile%>" description="<%$ LemoonResources: SelectFile%>" css="hidden uploadsimple" />
    <lemoon:textfield id="description" runat="server" label="<%$ LemoonResources: Description%>" description="<%$ LemoonResources: UploadDescriptionHelpText%>" width="300px" />
    <lemoon:booleanfield id="uncompress" runat="server" label="<%$ LemoonResources: UncompressFiles%>" />
    <lemoon:buttons runat="server">
      <lemoon:htmlbutton id="save" runat="server" text="<%$ LemoonResources: Upload%>" shortcut="Ctrl+Shift+S" onclientclick="ExecuteUpload();" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
</asp:content>
