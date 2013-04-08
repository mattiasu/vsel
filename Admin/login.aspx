<%@ page language="C#" autoeventwireup="true" codebehind="login.aspx.cs" inherits="Mindroute.Lemoon.Admin.Login" masterpagefile="~/admin/master/simple.master" enableviewstate="false" %>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server" description="<%$ LemoonResources: LoginDescription%>">
    <lemoon:textfield id="username" runat="server" label="<%$ LemoonResources: Username%>" required="true" />
    <lemoon:textfield id="password" runat="server" label="<%$ LemoonResources: Password%>" required="true" textmode="Password" />
    <lemoon:booleanfield id="rememberme" runat="server" label="<%$ LemoonResources: RememberMe%>" />
    <div class="buttons">
      <lemoon:button id="login" runat="server" text="<%$ LemoonResources: Login%>" onclick="login_Click" default="true" />
      <lemoon:anchor id="lost" runat="server" text="<%$ LemoonResources: LostPassword %>" href="~/admin/upgrade/passwordreset.aspx" />
    </div>
  </lemoon:fieldset>
</asp:content>
