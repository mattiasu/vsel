<%@ page title="" language="C#" masterpagefile="~/Lemoon/MasterPages/Site.Master" autoeventwireup="true" codebehind="ErrorTemplate.aspx.cs" inherits="vsel.Lemoon.Templates.ErrorTemplate" %>

<asp:content contentplaceholderid="mainplh" runat="server">
  <h1><%: Content.Title %></h1>
  <%= Content.Body %>
</asp:content>
