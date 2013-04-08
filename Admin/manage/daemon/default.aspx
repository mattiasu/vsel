<%@ page language="C#" autoeventwireup="false" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Daemon.Default" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ import namespace="Mindroute.Core.Model" %>
<%@ import namespace="Mindroute.Core.Daemons" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <table class="list">
    <col width="200" />
    <col width="*" />
    <col width="130" />
    <col width="95" />
    <col width="95" />
    <col width="95" />
    <thead>
      <tr>
        <th><%= Mindroute.Lemoon.Properties.Resources.Name%></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Description%></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.LastRun%></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Interval%></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Status%></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Actions%></th>
      </tr>
    </thead>
    <tbody>
    <% int i = 0; 
      string css = string.Empty;
      foreach (var daemon in Daemons) { 
      css = (i++ % 2 == 0) ? string.Empty : "alt";
      if (!daemon.IsLoaded) {
          css += " error";
      } else if (!daemon.IsEnabled) {
          css += " disabled";
      } %>
      <tr class="<%= css %>">
        <td><a href="<%= ResolveUrl("~/admin/manage/daemon/edit.aspx?eid=" + daemon.ID) %>"><span class="icon-12 <%= daemon.Icon ?? "daemon" %>"></span><%= daemon.DisplayName %></a></td>
        <td class="ellipsis"><%= daemon.Description %></td>
        <td><%= daemon.LastRun.ToText() %></td>
        <td><%= daemon.Interval %></td>
        <td><%= daemon.Status %></td>
        <td class="actions"><%= GetActionLinks(daemon) %></td>
      </tr>
    <% } %>
    </tbody>
  </table>
</asp:content>
