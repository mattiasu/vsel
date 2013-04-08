<%@ page language="C#" autoeventwireup="true" codebehind="passwordreset.aspx.cs" inherits="Mindroute.Lemoon.Admin.PasswordReset" masterpagefile="~/admin/master/simple.master" enableviewstate="false" %>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server" description="<%$ LemoonResources: LostPasswordDescription%>">
    <lemoon:emailfield id="email" runat="server" label="<%$ LemoonResources: Email%>" required="true" />
    <lemoon:buttons runat="server">
      <lemoon:button id="reset" runat="server" text="<%$ LemoonResources: SendPassword%>" onclick="reset_Click" default="true" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/login.aspx" />
    </lemoon:buttons>
  </lemoon:fieldset>
</asp:content>
