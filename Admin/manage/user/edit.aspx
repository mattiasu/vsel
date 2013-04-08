<%@ page language="C#" autoeventwireup="false" codebehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._User.Edit" masterpagefile="~/admin/master/main.master" enableeventvalidation="false" %>
<%@ register src="~/admin/controls/metadata.ascx" tagname="metadata" tagprefix="lemoon" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content" enableviewstate="false">
  <lemoon:fieldset id="edit" runat="server">
    <lemoon:textfield id="name" runat="server" required="true" label="<%$ LemoonResources: Name%>" width="200px" />
    <lemoon:textfield id="username" runat="server" required="true" label="<%$ LemoonResources: Username%>" description="<%$ LemoonResources: UsernameDescription%>" width="200px" />
    <lemoon:emailfield id="email" runat="server" label="<%$ LemoonResources: Email%>" width="200px" />
    <lemoon:passwordfield id="password" runat="server" required="true" label="<%$ LemoonResources: Password%>" passwordstrengthindicator="true" width="200px" />
    <lemoon:passwordfield id="repeatpassword" runat="server" label="<%$ LemoonResources: RepeatPassword%>" width="200px" enableviewstate="false" />
    <lemoon:textfield id="description" runat="server" width="400px" height="60px" label="<%$ LemoonResources: Description%>" textmode="MultiLine" />
    <lemoon:booleanfield id="admin" runat="server" label="<%$ LemoonResources: Administrator%>" />
    <lemoon:booleanfield id="enabled" runat="server" label="<%$ LemoonResources: Enabled%>" />
    <lemoon:rolesfield id="roles" runat="server" width="200px" height="150px" label="<%$ LemoonResources: GroupMembership%>" includesystemroles="false" />
    <lemoon:contentfield id="publicstartpage" runat="server" label="<%$ LemoonResources: DefaultLoginPage%>" description="<%$ LemoonResources: DefaultLoginPageDescription%>" />
  </lemoon:fieldset> 

  <lemoon:fieldset id="w_edit" runat="server" visible="false">
    <lemoon:labelfield id="w_name" runat="server" label="<%$ LemoonResources: Name%>" />
    <lemoon:labelfield id="w_username" runat="server" label="<%$ LemoonResources: Username%>" />
    <lemoon:labelfield id="w_email" runat="server" label="<%$ LemoonResources: Email%>" />
    <lemoon:labelfield id="w_description" runat="server" label="<%$ LemoonResources: Description%>" />
    <lemoon:booleanfield id="w_admin" runat="server" label="<%$ LemoonResources: Administrator%>" />    
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
    <lemoon:allowdenyfield id="policy17" runat="server" label="<%$ LemoonResources: PolicyManageWorkflow%>" description="<%$ LemoonResources: PolicyManageWorkflowDescription%>" />
  </lemoon:fieldset> 

  <lemoon:fieldset id="metadatatab" runat="server" enabled="false">
    <lemoon:metadata id="metadata" runat="server" />
  </lemoon:fieldset>

  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:button id="w_save" runat="server" text="<%$ LemoonResources: Save%>" onclick="SaveWindowsUser_Click" shortcut="Ctrl+Shift+S" visible="false" />
    <lemoon:linkbutton id="w_synchronize" runat="server" text="<%$ LemoonResources: Synchronize%>" onclick="Synchronize_Click" visible="false" />
    <lemoon:linkbutton id="delete" runat="server" text="<%$ LemoonResources: Delete%>" onclick="Delete_Click" causesvalidation="false" />
    <lemoon:button id="restore" runat="server" text="<%$ LemoonResources: Restore%>" onclick="Restore_Click" visible="false" />
    <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/manage/user/" shortcut="Esc" />
  </lemoon:buttons>
</asp:content>
