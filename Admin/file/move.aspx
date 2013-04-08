<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="move.aspx.cs" inherits="Mindroute.Lemoon.Admin._File.Move" masterpagefile="~/admin/master/main.master" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:filemenu runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server">
    <lemoon:folderfield id="tree" runat="server" label="<%$ LemoonResources: TargetFolder %>" description="<%$ LemoonResources: SelectDestinationHelpText%>" required="true" enableviewstate="false" />
    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="save_Click" shortcut="Ctrl+Shift+S" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/file/default.aspx?id={id}" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
<script type="text/javascript">
</script>
</asp:content>
