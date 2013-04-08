<%@ page language="C#" autoeventwireup="false" codebehind="settings.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._System.Settings" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ register src="~/admin/controls/customsettings.ascx" tagname="customsettings" tagprefix="lemoon" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
  <lemoon:fieldset id="settingsTab" runat="server">
    <lemoon:booleanfield id="allowPasswordReset" runat="server" label="<%$ LemoonResources: AllowPasswordReset%>" description="<%$ LemoonResources: AllowPasswordResetDescription%>" />
  </lemoon:fieldset> 
  
  <lemoon:fieldset id="customTab" runat="server" enabled="false">
    <lemoon:customsettings id="customSettings" runat="server" />
  </lemoon:fieldset> 

  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:anchor id="cancel" runat="server" href="~/admin/manage/" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
  </lemoon:buttons>
</asp:content>
