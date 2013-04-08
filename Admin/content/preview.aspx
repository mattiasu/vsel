<%@ page language="C#" autoeventwireup="true" codebehind="preview.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Preview" masterpagefile="~/admin/master/main.master" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="f" runat="server" description="<%$ LemoonResources: PreviewPageDescription%>">
    <lemoon:datetimefield id="fromdate" runat="server" label="<%$ LemoonResources: PreviewFromDate%>" description="" />
    <lemoon:booleanfield id="showhidden" runat="server" label="<%$ LemoonResources: ShowHiddenPages%>" description="" />
    <lemoon:buttons runat="server">
      <lemoon:button id="preview" runat="server" text="<%$ LemoonResources: Preview%>" onclick="Preview_Click" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc"/>
    </lemoon:buttons>
  </lemoon:fieldset> 
</asp:content>
