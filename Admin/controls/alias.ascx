<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="alias.ascx.cs" Inherits="Mindroute.Lemoon.Admin.Controls.Alias" %>



<div class="field">
  <label><%= Mindroute.Lemoon.Properties.Resources.Aliases %></label>
  <table id="alias">
    <col width="110" />
    <col width="400" />
    <col />
    <thead>
      <tr>
        <th>Status</th>
        <th>Alias</th>
        <th class="actions"></th>
      </tr>
    </thead>
    <tfoot>
      <tr class="add">
        <td>
          <a href="javascript:;" onclick="LemoonAlias.Add();return false;"><span class="icon-12 add"></span><%= Mindroute.Lemoon.Properties.Resources.AddAlias %></a>
        </td>
        <td colspan="2"><asp:literal id="e" runat="server" /></td>
      </tr>
    </tfoot>
    <tbody>
    <% foreach (var alias in Aliases) { %>         
        <tr>
          <td>
            <select name="alias_code">
              <option value="200" <% if (alias.Code == Mindroute.Core.Model.AliasCode.OK) { %>selected="selected"<% } %>>200 OK</option>
              <option value="301" <% if (alias.Code == Mindroute.Core.Model.AliasCode.MovedPermanently) { %>selected="selected"<% } %>>301 Moved</option>
              <option value="302" <% if (alias.Code == Mindroute.Core.Model.AliasCode.Found) { %>selected="selected"<% } %>>302 Found</option>
            </select>
          </td>
          <td><input type="text" name="alias_route" value="<%= alias.Route %>" /></td>
          <td class="actions"><a href="#"><span class="icon-12 delete" onclick="LemoonAlias.Remove(this);"></span></a></td>
        </tr>
    <% } %>
    </tbody>
  </table>
  
  
</div>