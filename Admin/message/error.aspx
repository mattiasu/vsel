<%@ page language="C#" autoeventwireup="true" codebehind="error.aspx.cs" inherits="Mindroute.Lemoon.Admin.Message.Error" masterpagefile="~/admin/master/simple.master" enableviewstate="false" %>

<asp:content contentplaceholderid="content" runat="server">
  <h1><%= Mindroute.Lemoon.Properties.Resources.ServerError %></h1>
  <p><%= string.Format(Mindroute.Lemoon.Properties.Resources.ServerErrorDescription, ResolveUrl("~/admin/manage/logs/default.aspx?v=lemoon.log")) %></p>
</asp:content>
