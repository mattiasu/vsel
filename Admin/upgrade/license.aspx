<%@ page language="C#" autoeventwireup="true" codebehind="license.aspx.cs" inherits="Mindroute.Lemoon.Admin.Upgrade._License" masterpagefile="~/admin/master/simple.master" enableviewstate="false" %>

<asp:content contentplaceholderid="content" runat="server">

  <lemoon:fieldset id="fieldset" runat="server" title="<%$ LemoonResources: UpdateLicense%>" description="<%$ LemoonResources: UpdateLicenseDescription%>">
    <lemoon:textfield id="licenseField" runat="server" label="<%$ LemoonResources: LicenseKey%>" required="true" />    
    <lemoon:buttons runat="server">
      <lemoon:button id="updateButton" runat="server" text="<%$ LemoonResources: Update%>" onclick="update_Click" shortcut="Ctrl+Shift+S" default="true" />
      <lemoon:anchor id="cancelButton" href="~/admin/" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="ESC" />
    </lemoon:buttons>
  </lemoon:fieldset>
    
</asp:content>
