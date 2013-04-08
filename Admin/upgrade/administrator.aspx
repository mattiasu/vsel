<%@ page language="C#" autoeventwireup="true" codebehind="administrator.aspx.cs" inherits="Mindroute.Lemoon.Admin.Upgrade.Administrator" masterpagefile="~/admin/master/simple.master" enableviewstate="false" %>

<asp:content contentplaceholderid="content" runat="server">

  <lemoon:fieldset id="windows" runat="server" title="<%$ LemoonResources: CreateAdministrator %>" description="<%$ LemoonResources: NoWindowsAdministratorAccount %>">
    <lemoon:buttons runat="server" cssclass="vertical">
      <lemoon:button id="yesButton" runat="server" text="<%$ LemoonResources: Yes %>" onclick="YesClick" />
      <lemoon:anchor id="noButton" runat="server" href="~/" text="<%$ LemoonResources: No %>" />
    </lemoon:buttons>
  </lemoon:fieldset>
  
  <lemoon:fieldset id="forms" runat="server" title="<%$ LemoonResources: CreateAdministrator %>" description="<%$ LemoonResources: NoFormsAdministratorAccount %>">
    <lemoon:textfield id="username" runat="server" label="<%$ LemoonResources: Username%>" required="true" />
    <lemoon:passwordfield id="password" runat="server" label="<%$ LemoonResources: Password%>" required="true" />
    <lemoon:buttons runat="server">
      <lemoon:button id="saveButton" runat="server" text="<%$ LemoonResources: Save %>" onclick="SaveClick" />
      <lemoon:anchor id="cancelButton" runat="server" href="~/admin/login.aspx" text="<%$ LemoonResources: Cancel %>" />
    </lemoon:buttons>
  </lemoon:fieldset>

</asp:content>
