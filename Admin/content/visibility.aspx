<%@ page language="C#" autoeventwireup="true" codebehind="visibility.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Visibility" masterpagefile="~/admin/master/main.master" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server" description="<%$ LemoonResources: VisibilityDescription%>">
    <asp:validationsummary runat="server" />
    <lemoon:radiofield id="action" runat="server" label="<%$ LemoonResources: Action%>" />
    <lemoon:radiofield id="method" runat="server" label="<%$ LemoonResources: ApplyTo%>" />
  </lemoon:fieldset>
  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:anchor runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/content/?id={id}" shortcut="Esc" />
  </lemoon:buttons>
</asp:content>
