<%@ page title="" language="C#" masterpagefile="~/admin/master/main.master" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Default" %>

<asp:content contentplaceholderid="head" runat="server">
  <script type="text/javascript" src="<%= ResolveUrl("~/admin/js/lemoon.widget.js") %>"></script>
  <link type="text/css" href="<%= ThemeService.GetUrl("dashboard.css") %>" rel="stylesheet" media="screen" />
  <asp:literal id="style" runat="server" />
</asp:content>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:menu id="menu" runat="server" />
</asp:content>

<asp:content id="content" contentplaceholderid="content" runat="server">
  <div id="dashboard">
    <ul id="column1" class="column">
      <asp:placeholder id="col0" runat="server" />
    </ul>
    <ul id="column2" class="column">
      <asp:placeholder id="col1" runat="server" />
    </ul>
    <ul id="column3" class="column">
      <asp:placeholder id="col2" runat="server" />
    </ul>
  </div>
  <script type="text/javascript" src="<%= ResolveUrl("~/admin/js/jquery.json-2.2.min.js") %>"></script>
  <script type="text/javascript" src="<%= ResolveUrl("~/admin/js/lemoon.dashboard.js") %>"></script>
</asp:content>
