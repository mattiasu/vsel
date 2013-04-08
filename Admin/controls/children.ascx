<%@ control language="C#" autoeventwireup="false" codebehind="children.ascx.cs" inherits="Mindroute.Lemoon.Admin.Controls.Children" enableviewstate="false" %>

<table>
  <col width="*" />
  <col width="200" />
  <col width="95" />
  <col width="95" />
  <thead>
    <tr>
      <th><%= Mindroute.Lemoon.Properties.Resources.Children %> (<%= Items.TotalItemCount %>)</th>
      <th><%= Mindroute.Lemoon.Properties.Resources.CreatedBy %></th>
      <th><%= Mindroute.Lemoon.Properties.Resources.Created %></th>
      <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Actions %></th>
    </tr>
  </thead>
  <tbody>
  <% int i = 0; foreach (var item in Items) { %>
    <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
      <td class="ctmenu"><a href="<%= ResolveUrl("~/admin/content/default.aspx?id=") + item.ID %>"<%= GetTitle(item) %><%= GetCss(item) %> data-id="<%=item.ID %>" ><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Title.HtmlSafe() + (item.LanguageID == Site.LanguageID ? "" : "  [" + item.Site.LanguageCode + "]") %></span></a></td>
      <td><%= item.CreatedBy.DisplayName.HtmlSafe() %></td>
      <td><%= item.Created.ToText()%></td>
      <td class="actions">
        <% if (HasEdit(item)) {
             if (item.LanguageID != Site.LanguageID) {
               %>
        <a href="<%= ResolveUrl("~/admin/content/edit.aspx?action=translate&id=") + item.ID %>" title="<%= Mindroute.Lemoon.Properties.Resources.Translate %>"><span class="icon-12 edit"></span></a>
          <%} else {%>
        <a href="<%= ResolveUrl("~/admin/content/edit.aspx?id=") + item.ID %>" title="<%= Mindroute.Lemoon.Properties.Resources.Edit %>"><span class="icon-12 edit"></span></a>
        <%    }
           } %>
        <a href="<%= GetUrl(item) %>" title="<%= Mindroute.Lemoon.Properties.Resources.View %>" target="_blank"><span class="icon-12 view-preview"></span></a>
        <% if (HasDelete(item)) { %>
        <a href="javascript:void(0);" title="<%= Mindroute.Lemoon.Properties.Resources.Trash %>" onclick="if (!window.confirm('<%= Mindroute.Lemoon.Properties.Resources.ConfirmTrashContent %>')) { return false; } else { Lemoon.DeleteContent(<%= item.ID %>, '<%= ResolveUrl("~/admin/content/default.aspx?id=") + item.ID %>') }"><span class="icon-12 recycle-bin"></span></a>
        <% } %>
      </td>
    </tr>
  <% } %>
  </tbody>
</table>

<div class="pager">
  <lemoon:pagenumbers id="pagenumbers" runat="server" />
  <lemoon:pagesizer id="pagesizer" runat="server" />
</div>

<lemoon:contextmenu runat="server" type="children" />