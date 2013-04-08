<%@ page Language="C#" AutoEventWireup="false" CodeBehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Content.Default" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
  <lemoon:fieldset runat="server" id="field">
    <table style="table-layout:fixed;">
      <col width="200" />
      <col width="*" />
      <col width="300" />
      <col width="95" />
      <thead>
        <tr>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Name%>" /></th>
          <th class="ellipsis"><asp:localize runat="server" text="<%$ LemoonResources: Description %>" /></th>
          <th><asp:localize runat="server" id="templateHead" text="<%$ LemoonResources: Template%>" /></th>
          <th class="actions"><asp:localize runat="server" text="<%$ LemoonResources: Actions%>" /></th>
        </tr>
      </thead>
      <tbody> 
        <asp:repeater id="types" runat="server" onitemdatabound="Types_ItemDataBound">
          <itemtemplate>
            <tr id="row" runat="server">
              <td><a id="name" runat="server" /></td>
              <td class="ellipsis"><%#((Mindroute.Core.Model.ContentType)Container.DataItem).Description %></td>
              <td id="template" runat="server" />
              <td class="actions">
                <asp:linkbutton id="extra" runat="server" oncommand="Extra_OnCommand" />
                <a id="edit" runat="server" title="<%$ LemoonResources: Edit%>"><span class="icon-12 edit"></span></a>
                <a id="design" runat="server" title="<%$ LemoonResources: Design%>"><span class="icon-12 design"></span></a>
                <asp:linkbutton id="delete" runat="server" oncommand="Delete_OnCommand" />
              </td>
            </tr>
          </itemtemplate>
        </asp:repeater>
      </tbody>
    </table>          
  </lemoon:fieldset>
</asp:content>