<%@ page language="C#" autoeventwireup="false" codebehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Plugin.Edit" masterpagefile="~/admin/master/main.master" %>
<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset runat="server" id="properties">
    <lemoon:labelfield id="name" runat="server" label="<%$ LemoonResources: Name%>" />
    <lemoon:labelfield id="description" runat="server" label="<%$ LemoonResources: Description%>" /> 
    <asp:placeholder id="labelControls" runat="server" />
    <lemoon:booleanfield id="enabled" runat="server" label="<%$ LemoonResources: Enabled %>" />
  </lemoon:fieldset>

  <lemoon:fieldset id="settings" runat="server" enabled="false">
    <asp:placeholder id="editControls" runat="server" />
  </lemoon:fieldset>   

  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save %>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:anchor id="cancel" href="~/admin/manage/plugin/default.aspx" runat="server" text="<%$ LemoonResources: Cancel %>" shortcut="esc" />
  </lemoon:buttons>    
  
</asp:content>
