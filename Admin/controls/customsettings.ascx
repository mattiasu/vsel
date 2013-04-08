<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="customsettings.ascx.cs" Inherits="Mindroute.Lemoon.Admin.controls.CustomSettings" enableviewstate="false" %>
<div class="field">
  <label><asp:localize id="Localize1" runat="server" text="<%$ LemoonResources: CustomSettings %>" /></label>
  <table id="customsettings">
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
          <a href="javascript:void(0);" onclick="LemoonMetadata.AddMetaData('customsettings');return false;"><span class="icon-12 add"></span>
            <asp:localize id="Localize5" runat="server" text="<%$ LemoonResources: AddCustomSettings %>" /></a>
        </td>
      </tr>
    </tfoot>
    <asp:repeater id="repeater" runat="server" onitemdatabound="repeater_ItemDataBound">
      <itemtemplate>
      <tr>
          <td>
            <input type="text" name="mkeycustomsettings" value="<%#((KeyValuePair<string, Mindroute.Core.Model.PersistedValue>)Container.DataItem).Key%>" />
          </td>
          <td>
            <select name="mtypcustomsettings">
              <asp:literal id="options" runat="server" />
            </select>
          </td>
          <td>
            <input type="text" name="mvalcustomsettings" value="<%#((KeyValuePair<string, Mindroute.Core.Model.PersistedValue>)Container.DataItem).Value.Value%>" />
          </td>
          <td class="actions">
            <a href="javascript:void(0);"><span class="icon-12 delete" onclick="LemoonMetadata.Remove(this);"></span></a>
          </td>
        </tr>
      </itemtemplate>
    </asp:repeater>
  </table>
</div>
