<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="userprofile.aspx.cs" Inherits="Mindroute.Lemoon.Admin.Manage._User.UserProfile" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>

<asp:content runat="server" contentplaceholderid="content">
  <lemoon:fieldset id="fieldset" runat="server">
    <lemoon:radiobuttonsfield id="languages" runat="server" label="<%$ LemoonResources: Language%>" description="<%$ LemoonResources: LanguageDescription%>" />
    <lemoon:booleanfield id="developerMode" runat="server" label="<%$ LemoonResources: DeveloperMode%>" description="<%$ LemoonResources: DeveloperModeDescription%>" />
    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="save_Click" shortcut="Ctrl+Shift+S" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
</asp:content>
