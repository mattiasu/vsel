<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="revisions.aspx.cs" inherits="Mindroute.Lemoon.Admin._File.Revisions" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">

  <p class="description"><%= Mindroute.Lemoon.Properties.Resources.RevisionsFileDescription%></p>

  <table class="list">
    <col width="30" />            
    <col width="250" />
    <col width="*" />
    <col width="200" />
    <col width="95" />
    <col width="105" />
    <col width="95" />
    <col width="95" />
    <thead>
      <tr>
        <th>#</th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Description %></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.CreatedBy %></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Created %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Dimensions %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Size %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Actions %></th>
      </tr>
    </thead>
    <tbody>
      <% if (Versions.Count == 0) {%>
      <tr>
        <td colspan="7">
          <%= Mindroute.Lemoon.Properties.Resources.NoResults %>
        </td>
      </tr>
      <% } %>

      <% int i = 0; foreach (var item in Versions) { %>
        <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
          <td><%= item.Version %></td>
          <td><a href="<%= item.AdminFileUrl() %>" target="_blank"><span class="title"><%= item.Title.HtmlSafe() + (item.LanguageID == Site.LanguageID ? "" : "  [" + item.Site.LanguageCode + "]") %></span></a></td>
          <td class="ellipsis"><%= item.Description.HtmlSafe() %></td>
          <td><%= item.CreatedBy.DisplayName.HtmlSafe() %></td>
          <td><%= item.Created.ToText()%></td>
          <td class="actions"><%= item.Dimensions() %></td>
          <td class="actions"><%= FileHelper.FileSizeAsString(item.Size)%></td>
          <td class="actions">
            <% if (item.Version != null) { %>
              <% if (HasEdit(item)) { %>
              <a href="<%= GetRevertLink(item) %>;" title="<%= Mindroute.Lemoon.Properties.Resources.Revert %>" class="icon-12 restore" ></a>
              <% } %>
              <% if (HasDelete(item)) { %>
              <a href="<%= GetRemoveLink(item) %>;" title="<%= Mindroute.Lemoon.Properties.Resources.Delete %>" class="icon-12 delete"></a>
              <% } %>
            <% }  %>
          </td>
        </tr>
      <% } %>
      </tbody>
  </table>

  <lemoon:htmlbutton href="" id="back" runat="server" text="<%$ LemoonResources: Back%>" />

  <script type="text/javascript">
    $(document).ready(function () {
      $("a.restore").click(function () {
        return window.confirm('<%= Mindroute.Lemoon.Properties.Resources.ConfirmRevertRevision %>');
      });
    });
    $(document).ready(function () {
      $("a.delete").click(function () {
        return window.confirm('<%= Mindroute.Lemoon.Properties.Resources.ConfirmDeleteRevision %>');
      });
    });
  </script>
</asp:content>
