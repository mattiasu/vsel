<%@ page title="" language="C#" masterpagefile="~/Lemoon/MasterPages/Site.Master" autoeventwireup="true" codebehind="FormTemplate.aspx.cs" inherits="vsel.Lemoon.Templates.FormTemplate" %>

<asp:content contentplaceholderid="mainplh" runat="server">
  <h1><%: Content.Title %></h1>
  <%= Content.Body %>
  <controls:form id="form" runat="server" onsaveformevent="form_OnSave" onloadformevent="form_OnLoad" />
</asp:content>
