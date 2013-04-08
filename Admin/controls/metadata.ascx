<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="metadata.ascx.cs" Inherits="Mindroute.Lemoon.Admin.Controls.MetaData" enableviewstate="false" %>
<div class="field">
  <label><asp:localize runat="server" text="<%$ LemoonResources: MetaData %>" /></label>
  <table id="metadata">
    <col width="200" />
    <col width="200" />
    <col width="200" />
    <col width="*" />
    <thead>
      <tr>
        <th>
          <asp:localize runat="server" text="<%$ LemoonResources: Key %>" />
        </th>
        <th>
          <asp:localize runat="server" text="<%$ LemoonResources: Datatype %>" />
        </th>
        <th>
          <asp:localize runat="server" text="<%$ LemoonResources: Value %>" />
        </th>
        <th class="actions"></th>
      </tr>
    </thead>
    <tfoot>
      <tr class="add" enableviewstate="false">
        <td colspan="4">
          <a href="javascript:void(0);" onclick="LemoonMetadata.AddMetaData('metadata');return false;"><span class="icon-12 add"></span>
            <asp:localize runat="server" text="<%$ LemoonResources: AddMetaData %>" /></a>
        </td>
      </tr>
    </tfoot>
    <asp:repeater id="repeater" runat="server" onitemdatabound="repeater_ItemDataBound">
      <itemtemplate>
      <tr>
          <td>
            <input type="text" name="mkeymetadata" value="<%#((KeyValuePair<string,object>)Container.DataItem).Key%>" />
          </td>
          <td>
            <select name="mtypmetadata">
              <asp:literal id="options" runat="server" />
            </select>
          </td>
          <td>
            <input type="text" name="mvalmetadata" value="<%#((KeyValuePair<string,object>)Container.DataItem).Value%>" />
          </td>
          <td class="actions">
            <a href="javascript:void(0);"><span class="icon-12 delete" onclick="LemoonMetadata.Remove(this);"></span></a>
          </td>
        </tr>
      </itemtemplate>
    </asp:repeater>
  </table>
</div>
