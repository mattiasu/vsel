<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin._File.FileEdit" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ register src="~/admin/controls/metadata.ascx" tagname="metadata" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/properties.ascx" tagname="properties" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/visibility.ascx" tagname="visibility" tagprefix="lemoon" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>
<%@ import namespace="Mindroute.Lemoon.Helpers" %>

<asp:content contentplaceholderid="head" runat="server">
  <link type="text/css" href="<%=ResolveUrl("~/admin/theme/default/jquery.Jcrop.css") %>" rel="stylesheet" media="screen" />
  <script type="text/javascript" src="<%=ResolveUrl("~/admin/js/jquery.Jcrop.min.js") %>"></script>
</asp:content>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:filemenu id="fileMenu" runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">

  <fieldset id="edit" class="tab">

    <lemoon:textfield id="title" runat="server" label="<%$ LemoonResources: FileName%>" description="<%$ LemoonResources: FileNameDescription%>" required="true" />
    <lemoon:textfield id="description" runat="server" label="<%$ LemoonResources: Description%>" description="<%$ LemoonResources: ReplaceDescriptionHelpText%>" />
    <lemoon:tagfield id="tags" runat="server" label="<%$ LemoonResources: Tags%>" description="<%$ LemoonResources: TagsDescription%>" />
    <div class="field">
      <label><asp:localize runat="server" text="<%$ LemoonResources: Details %>" /></label>
      <%= Mindroute.Lemoon.Web.UI.Admin.HtmlFragment.Thumbnail(Content as Mindroute.Core.Model.Document, GetUrl(Content), "_blank", null, null, false, false, false, false, null)%>
    </div>
    <div class="field">
      <label id="selectFile" runat="server" />
      <input type="file" id="file" runat="server" />
      <div class="info"><asp:localize runat="server" text="<%$ LemoonResources: ReplaceFileHelpText%>" /></div>
    </div>
  </fieldset>
      
  <lemoon:fieldset id="propertiestab" runat="server" enabled="false">
    <lemoon:properties id="properties" runat="server" />    
  </lemoon:fieldset> 
    
  <lemoon:fieldset id="visibilitytab" runat="server" enabled="false">
    <lemoon:visibility id="visibility" runat="server" />    
  </lemoon:fieldset> 
    
  <lemoon:fieldset id="metadatatab" runat="server" enabled="false">
    <lemoon:metadata id="metadata" runat="server" />
  </lemoon:fieldset>

<%-- 
  <lemoon:fieldset id="croptab" runat="server" enabled="false">
    <img id="crop" runat="server" alt="" />

    <input type="hidden" id="cropWidth" name="cropWidth" />
    <input type="hidden" id="cropHeigth" name="cropHeigth" />
    <input type="hidden" id="cropX" name="cropX" />
    <input type="hidden" id="cropY" name="cropY" />

    <script type="text/javascript">
      $(function () {
        //activateCrop();
      });
      var isRunning = false;
      function selectCropCoords(c) {
        $('#cropWidth').val(Math.round(c.w * LemoonCrop.Ratio));
        $('#cropHeigth').val(Math.round(c.h * LemoonCrop.Ratio));
        $('#cropX').val(Math.round(c.x * LemoonCrop.Ratio));
        $('#cropY').val(Math.round(c.y * LemoonCrop.Ratio));
      };

      function activateCrop() {
        if (!isRunning) {
          var jcropApi = $.Jcrop('#<%=crop.ClientID %>', {
            onSelect: selectCropCoords
          });
          isRunning = true;
        }
      }
    </script>
  </lemoon:fieldset>
 
--%>

  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" shortcut="Ctrl+Shift+S" onclick="save_Click" />
    <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
  </lemoon:buttons>
</asp:content>
