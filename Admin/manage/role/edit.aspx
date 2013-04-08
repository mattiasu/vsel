<%@ page language="C#" autoeventwireup="false" codebehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Role.Edit" masterpagefile="~/admin/master/main.master" enableeventvalidation="false" %>
<%@ register src="~/admin/controls/metadata.ascx" tagname="metadata" tagprefix="lemoon" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
  <lemoon:fieldset id="edit" runat="server">
    <lemoon:textfield id="name" runat="server" required="true" width="200px" label="<%$ LemoonResources: Name%>" />
    <lemoon:textfield id="description" runat="server" width="400px" height="60px" label="<%$ LemoonResources: Description%>" textmode="MultiLine" />
    <lemoon:usersfield id="members" runat="server" width="200px" height="150px" label="<%$ LemoonResources: Members%>" />
    <lemoon:contentfield id="publicstartpage" runat="server" label="<%$ LemoonResources: DefaultLoginPage%>" description="<%$ LemoonResources: DefaultLoginPageRoleDescription%>" />
  </lemoon:fieldset> 

  <lemoon:fieldset id="w_edit" runat="server" visible="false">
    <lemoon:labelfield id="w_name" runat="server" label="<%$ LemoonResources: Name%>" />
    <lemoon:labelfield id="w_description" runat="server" label="<%$ LemoonResources: Description%>" />
    <lemoon:labelfield id="w_members" runat="server" label="<%$ LemoonResources: Members%>" />
  </lemoon:fieldset> 
  
  <lemoon:fieldset id="policy" runat="server" description="<%$ LemoonResources: PoliciesDescription%>" enabled="false">
    <lemoon:allowdenyfield id="policy0" runat="server" label="<%$ LemoonResources: PolicyLoginEditorial%>" description="<%$ LemoonResources: PolicyLoginEditorialDescription%>" />
    <lemoon:allowdenyfield id="policy1" runat="server" label="<%$ LemoonResources: PolicyDashboard%>" description="<%$ LemoonResources: PolicyDashboardDescription%>" />
    <lemoon:allowdenyfield id="policy2" runat="server" label="<%$ LemoonResources: PolicyContent%>" description="<%$ LemoonResources: PolicyContentDescription%>" />
    <lemoon:allowdenyfield id="policy3" runat="server" label="<%$ LemoonResources: PolicyFiles%>" description="<%$ LemoonResources: PolicyFilesDescription%>" />
    <lemoon:allowdenyfield id="policy4" runat="server" label="<%$ LemoonResources: PolicyManage%>" description="<%$ LemoonResources: PolicyManageDescription%>" />
    <lemoon:allowdenyfield id="policy5" runat="server" label="<%$ LemoonResources: PolicyManageSite%>" description="<%$ LemoonResources: PolicyManageSiteDescription%>" />
    <lemoon:allowdenyfield id="policy6" runat="server" label="<%$ LemoonResources: PolicyManageUser%>" description="<%$ LemoonResources: PolicyManageUserDescription%>" />
    <lemoon:allowdenyfield id="policy7" runat="server" label="<%$ LemoonResources: PolicyManageRole%>" description="<%$ LemoonResources: PolicyManageRoleDescription%>" />
    <lemoon:allowdenyfield id="policy8" runat="server" label="<%$ LemoonResources: PolicyManageContentType%>" description="<%$ LemoonResources: PolicyManageContentTypeDescription%>" />
    <lemoon:allowdenyfield id="policy9" runat="server" label="<%$ LemoonResources: PolicyGlobalPermissionContent%>" description="<%$ LemoonResources: PolicyGlobalPermissionContentDescription%>" />
    <lemoon:allowdenyfield id="policy10" runat="server" label="<%$ LemoonResources: PolicyGlobalPermissionSite%>" description="<%$ LemoonResources: PolicyGlobalPermissionSiteDescription%>" />
    <lemoon:allowdenyfield id="policy11" runat="server" label="<%$ LemoonResources: PolicyRecyclebin%>" description="<%$ LemoonResources: PolicyRecyclebinDescription%>" />
    <lemoon:allowdenyfield id="policy12" runat="server" label="<%$ LemoonResources: PolicySetting%>" description="<%$ LemoonResources: PolicySettingDescription%>" />
    <lemoon:allowdenyfield id="policy13" runat="server" label="<%$ LemoonResources: PolicyDaemons%>" description="<%$ LemoonResources: PolicyDaemonsDescription%>" />
    <lemoon:allowdenyfield id="policy14" runat="server" label="<%$ LemoonResources: PolicyPlugins%>" description="<%$ LemoonResources: PolicyPluginsDescription%>" />
    <lemoon:allowdenyfield id="policy18" runat="server" label="<%$ LemoonResources: PolicyFunctions%>" description="<%$ LemoonResources: PolicyFunctionsDescription%>" />
    <lemoon:allowdenyfield id="policy15" runat="server" label="<%$ LemoonResources: PolicySysInformation%>" description="<%$ LemoonResources: PolicySysInformationDescription%>" />
    <lemoon:allowdenyfield id="policy16" runat="server" label="<%$ LemoonResources: PolicyManageDashboard%>" description="<%$ LemoonResources: PolicyManageDashboardDescription%>" />
  </lemoon:fieldset> 

  <lemoon:fieldset id="metadatatab" runat="server" enabled="false">
    <lemoon:metadata id="metadata" runat="server" />
  </lemoon:fieldset>

  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:linkbutton id="delete" runat="server" text="<%$ LemoonResources: Delete%>" onclick="Delete_Click" />
    <lemoon:anchor runat="server" href="~/admin/manage/role/" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
  </lemoon:buttons>
</asp:content>
