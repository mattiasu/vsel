<%@ page language="C#" autoeventwireup="true" codebehind="permissions.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Permissions" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  
  <div id="globalPermissions" runat="server">
    <table id="global" class="list">
      <col width="*" />
      <col width="75" />
      <col width="75" />
      <col width="75" />
      <col width="75" />
      <col width="75" />
      <col width="30" />
      <thead>
        <tr>
          <th><%=_header %></th>
          <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.ReadDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Read%>"/></th>
          <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.CreateDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Create%>"/></th>
          <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.EditDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Edit%>"/></th>
          <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.DeleteDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Delete%>"/></th>
          <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.AdminDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Admin%>"/></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <asp:repeater id="global" runat="server" onitemdatabound="Global_ItemDataBound">
          <itemtemplate>
            <tr>
              <td><asp:literal id="name" runat="server" /></td>
              <td><span id="read" runat="server" /></td>
              <td><span id="create" runat="server" /></td>
              <td><span id="edit" runat="server" /></td>
              <td><span id="delete" runat="server" /></td>
              <td><span id="admin" runat="server" /></td>
              <td></td>
            </tr>
          </itemtemplate>
        </asp:repeater>
      </tbody>
    </table>
  </div>
  <table id="permissions" class="list">
    <col width="*" />
    <col width="75" />
    <col width="75" />
    <col width="75" />
    <col width="75" />
    <col width="75" />
    <col width="30" />
    <thead class="rotator">
      <tr>
        <th><asp:literal id="contentHeader" runat="server" /></th>
        <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.ReadDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Read%>"/></th>
        <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.CreateDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Create%>"/></th>
        <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.EditDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Edit%>"/></th>
        <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.DeleteDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Delete%>"/></th>
        <th class="rotator" title="<%=Mindroute.Lemoon.Properties.Resources.AdminDescription %>"><asp:localize runat="server" text="<%$ LemoonResources: Admin%>"/></th>
        <th></th>
      </tr>
    </thead>
    <tfoot>
      <tr>
        <td colspan="7">
          <a href="javascript:void(0);" onclick="LemoonPicker.OpenUserPickerForPermissions()"><span class="icon-12 add"></span><%= Mindroute.Lemoon.Properties.Resources.AddUser %></a>
          <a href="javascript:void(0);" onclick="LemoonPicker.OpenRolePickerForPermissions()"><span class="icon-12 add"></span><%= Mindroute.Lemoon.Properties.Resources.AddRole %></a>
        </td>
      </tr>
    </tfoot>    
    <tbody>
      <asp:repeater id="entries" runat="server" onitemdatabound="Entries_ItemDataBound">
        <itemtemplate>
          <tr>
            <td>
              <asp:literal id="name" runat="server" />
              <asp:literal id="entity" runat="server" />
            </td>
            <td><asp:literal id="read" runat="server" /></td>
            <td><asp:literal id="create" runat="server" /></td>
            <td><asp:literal id="edit" runat="server" /></td>
            <td><asp:literal id="delete" runat="server" /></td>
            <td><asp:literal id="admin" runat="server" /></td>
            <td id="remove" runat="server"><a href="#" class="delentity"><span class="icon-12 delete"></span></a></td>
          </tr>
        </itemtemplate>
      </asp:repeater>
    </tbody>
  </table>
    <lemoon:radiofield id="recursion" runat="server" label="<%$ LemoonResources: ApplyTo%>" description="<%$ LemoonResources: ApplyToHelpText%>" />
    <lemoon:buttons runat="server" cssclass="vertical">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="esc" />
    </lemoon:buttons>

</asp:content>
