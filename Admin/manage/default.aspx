<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage.Default" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">

<div id="manage">
  <div id="site" runat="server">
    <h2><span class="icon-48 blue site"></span><asp:localize runat="server" text="<%$ LemoonResources: ManageSites%>" /></h2>
    <p><asp:localize runat="server" text="<%$ LemoonResources: ManageSitesDescription%>" /></p>
    <ul>
      <li id="managesite" runat="server" >
        <a runat="server" href="~/admin/manage/site/"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: Sites%>" /></a>
      </li>
      <li id="sitepermissions" runat="server">
        <a runat="server" href="~/admin/content/permissions.aspx?action=site"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: Permissions%>" /></a>
      </li>
    </ul>
  </div>
  <div id="user" runat="server">
    <h2><span class="icon-48 blue role"></span><asp:localize runat="server" text="<%$ LemoonResources: UsersAndRoles%>" /></h2>
    <p><asp:localize runat="server" text="<%$ LemoonResources: UsersAndRolesDescription%>" /></p>
    <ul>
      <li id="manageusers" runat="server">
        <a runat="server" href="~/admin/manage/user/default.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: ManageUsers%>" /></a>
      </li>
      <li id="importusers" runat="server">
        <a runat="server" href="~/admin/manage/user/import.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: ImportUsers%>" /></a>
      </li>
      <li id="manageroles" runat="server">
        <a runat="server" href="~/admin/manage/role/default.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: ManageRoles%>" /></a>
      </li>
      <li id="importroles" runat="server">
        <a runat="server" href="~/admin/manage/role/import.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: ImportRoles%>" /></a>
      </li>
    </ul>
  </div>
  <div id="content" runat="server">
    <h2><span class="icon-48 blue content"></span><asp:localize runat="server" text="<%$ LemoonResources: ManageContent%>" /></h2>
    <p><asp:localize runat="server" text="<%$ LemoonResources: ManageContentDescription%>" /></p>
    <ul>
      <li id="contenttypes" runat="server">
        <a runat="server" href="~/admin/manage/content/default.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: ContentTypes%>" /></a>
      </li>	
      <%--  
      <li id="forms" runat="server">
        <a runat="server" href="~/admin/manage/content/default.aspx?action=form"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: FormTemplates%>" /></a>
      </li>	
      --%>  
      <li id="recyclebin" runat="server">
        <a runat="server" href="~/admin/manage/content/recyclebin.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: RecycleBin%>" /></a>
      </li>
      <li id="contentpermissions" runat="server">
        <a runat="server" href="~/admin/content/permissions.aspx?action=content"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: Permissions%>" /></a>
      </li>
      <li id="workflow" runat="server">
        <a runat="server" href="~/admin/manage/workflow/default.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: Workflow%>" /></a>
      </li>
    </ul>
  </div>
  <div id="extensions" runat="server">
    <h2><span class="icon-48 blue plugin"></span><asp:localize runat="server" text="<%$ LemoonResources: Extensions%>" /></h2>
    <p><asp:localize runat="server" text="<%$ LemoonResources: ManageExtensionsDescription%>" /></p>
    <ul>
      <li id="functions" runat="server">
        <a runat="server" href="~/admin/manage/function/default.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: Functions%>" /></a>
      </li>
      <li id="plugins" runat="server">
        <a runat="server" href="~/admin/manage/plugin/default.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: Plugins%>" /></a>
      </li>
      <li id="daemons" runat="server">
        <a runat="server" href="~/admin/manage/daemon/default.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: Daemons%>" /></a>
      </li>
    </ul>
  </div>

  <div id="systemsettings" runat="server">
    <h2><span class="icon-48 blue manage"></span><asp:localize runat="server" text="<%$ LemoonResources: System%>" /></h2>
    <p><asp:localize runat="server" text="<%$ LemoonResources: SystemSettingsDescription%>" /></p>
    <ul>
      <li id="logs" runat="server">
        <a runat="server" href="~/admin/manage/logs/default.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: LogFiles%>" /></a>
      </li>
      <li id="settings" runat="server">
        <a runat="server" href="~/admin/manage/system/settings.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: SystemSettings%>" /></a>
      </li>
      <li id="sysinformation" runat="server">
        <a runat="server" href="~/admin/manage/system/default.aspx"><span class="icon-12 arrow-right"></span><asp:localize runat="server" text="<%$ LemoonResources: SystemInformation%>" /></a>
      </li>
    </ul>
  </div>

 
</div>

</asp:content>