<%@ page language="C#" autoeventwireup="false" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Plugin.Default" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ import namespace="Mindroute.Core.Model" %>
<%@ import namespace="Mindroute.Core.Plugins" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset runat="server">
    <table>
      <col width="200" />
      <col width="*" />
      <col width="95" />
      <thead>
        <tr>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Name%>" /></th>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Description%>" /></th>
          <th class="actions"><asp:localize runat="server" text="<%$ LemoonResources: Actions%>" /></th>
        </tr>
      </thead>
      <tbody>
        <tr id="pnoitems" runat="server" visible="false">
          <td colspan="3"><asp:localize runat="server" text="<%$ LemoonResources: NoResults%>" /></td>
        </tr>
        <asp:repeater id="plugins" runat="server" onitemdatabound="Plugins_ItemDataBound">
          <itemtemplate>
            <tr id="row" runat="server">
              <td><a id="name" runat="server"><span class="icon-12 <%# ((Plugin)Container.DataItem).Icon ?? "plugin" %>"></span><%#((Plugin)Container.DataItem).DisplayName%></a></td>
              <td><%#((Extension)Container.DataItem).Description%></td>
              <td class="actions">
                <asp:linkbutton id="extra" runat="server" oncommand="Extra_OnCommand" />
                <a id="edit" runat="server" title="<%$ LemoonResources: Edit%>"><span class="icon-12 edit"></span></a>
              </td>
            </tr>
          </itemtemplate>
        </asp:repeater>
      </tbody>
    </table>
  </lemoon:fieldset>
</asp:content>
