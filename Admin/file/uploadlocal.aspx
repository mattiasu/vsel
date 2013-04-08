<%@ page language="C#" autoeventwireup="false" codebehind="uploadlocal.aspx.cs" inherits="Mindroute.Lemoon.Admin._File.FileUploadLocal" masterpagefile="~/admin/master/main.master" %>

<asp:content contentplaceholderid="head" runat="server">
  <script type="text/javascript">
    function ExecuteUpload(disableButtons) {
      if (disableButtons == true) {
        window.setTimeout('DisableButtons()', 100);
      }
      else {
        EnableButtons();
      }
    }
    function EnableButtons() {
      $('#<%=save.ClientID %>').removeAttr('disabled');
      $('#<%=cancel.ClientID %>').removeAttr('disabled');
    }
    function DisableButtons() {
      $('#<%=save.ClientID %>').attr('disabled', 'true');
      $('#<%=cancel.ClientID %>').attr('disabled', 'true');
    }
  </script>
</asp:content>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:filemenu runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server">
    <lemoon:selectmanyfield id="localfiles" runat="server" label="<%$ LemoonResources: SelectFiles%>" description="<%$ LemoonResources: SelectFilesHelpText%>" width="300px" height="200px" required="true" selectionmode="Multiple" />
    <lemoon:textfield id="description" runat="server" label="<%$ LemoonResources: Description%>" description="<%$ LemoonResources: UploadDescriptionHelpText%>" width="300px" />
    <lemoon:booleanfield id="uncompress" runat="server" label="<%$ LemoonResources: UncompressFiles%>" description="<%$ LemoonResources: UncompressFilesHelpText%>" />
    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Upload%>" shortcut="Ctrl+Shift+S" onclick="save_Click" onclientclick="ExecuteUpload(true);" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
</asp:content>
