<%@ page language="C#" autoeventwireup="true" codebehind="changepassword.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._User.ChangePassword" masterpagefile="~/admin/master/main.master" %>

<asp:content runat="server" contentplaceholderid="content">
  <lemoon:fieldset id="fieldset" runat="server">
    <lemoon:passwordfield id="oldpassword" runat="server" label="<%$ LemoonResources: OldPassword%>" description="<%$ LemoonResources: OldPasswordHelpText%>" width="200px" required="true" enableviewstate="false" />
    <lemoon:passwordfield id="password" runat="server" label="<%$ LemoonResources: NewPassword%>" description="<%$ LemoonResources: NewPasswordHelpText%>" passwordstrengthindicator="true" width="200px" required="true" enableviewstate="false" />
    <lemoon:passwordfield id="verifypassword" runat="server" label="<%$ LemoonResources: VerifyPassword%>" description="<%$ LemoonResources: VerifyPasswordHelpText%>" width="200px" required="true" enableviewstate="false" />
    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="save_Click" shortcut="Ctrl+Shift+S" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
</asp:content>
