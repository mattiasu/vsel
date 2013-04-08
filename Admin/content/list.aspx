<%@ page language="C#" autoeventwireup="false" codebehind="list.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.List" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  &nbsp;<lemoon:devinfo runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
<div class="filter">
  <div class="group">
    <a id="g" runat="server"><%= Mindroute.Lemoon.Properties.Resources.All%></a>
    <a id="p" runat="server"><%= Mindroute.Lemoon.Properties.Resources.Published%></a>
    <a id="u" runat="server"><%= Mindroute.Lemoon.Properties.Resources.UnPublished%></a>
    <a id="t" runat="server"><%= Mindroute.Lemoon.Properties.Resources.Translated%></a>
    <a id="l" runat="server"><%= Mindroute.Lemoon.Properties.Resources.NotTranslated%></a>
  </div>
  <asp:dropdownlist id="ctList" runat="server" />
  <asp:textbox id="phrase" runat="server" />
</div>  

<table class="list">
  <col width="*" />
  <col width="200" />
  <col width="200" />
  <col width="95" />
  <col width="95" />
  <thead>
    <tr>
      <th><%= Mindroute.Lemoon.Properties.Resources.Pages %> (<%= Result.TotalItemCount %>)</th>
      <th><%= Mindroute.Lemoon.Properties.Resources.Parent %></th>
      <th><%= Mindroute.Lemoon.Properties.Resources.CreatedBy %></th>
      <th><%= Mindroute.Lemoon.Properties.Resources.Created %></th>
      <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Actions %></th>
    </tr>
  </thead>
  <tbody>
  <% if (Result.Count == 0) {%>
  <tr>
    <td colspan="5">
      <%= Mindroute.Lemoon.Properties.Resources.NoResults %>
    </td>
  </tr>
  <% } %>

  <% int i = 0; foreach (var item in Result) { %>
    <tr <% if (i++ % 2 != 0) {%>class="alt"<% } %>>
      <td class="ctmenu">
        <a data-id="<%=item.ID %>" href="<%= item.AdminUrl() %>"<%= GetTitle(item) %><%= GetCss(item) %>><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.MenuTitle().HtmlSafe() + (item.LanguageID == Site.LanguageID ? "" : "  [" + item.Site.LanguageCode + "]") %></span></a>
        <% if (_viewMode == "teaser") {%>
        <div><%=item.Teaser %></div>
        <% } %>
      </td>
      <td>
        <% if (item.Parent != null) { %>
        <a href="<%= item.Parent.AdminUrl() %>"<%= GetTitle(item.Parent) %>><%= item.Parent.MenuTitle().HtmlSafe() + (item.Parent.LanguageID == Site.LanguageID ? "" : "  [" + item.Parent.Site.LanguageCode + "]") %></span></a>
        <% } %>
      </td>
      <td><%= item.CreatedBy.DisplayName.HtmlSafe() %></td>
      <td><%= item.Created.ToText()%></td>
      <td class="actions">
        <% if (HasEdit(item)) {
             if (item.LanguageID != Site.LanguageID) { %>
        <a href="<%= ResolveUrl("~/admin/content/edit.aspx?action=translate&id=" + item.ID) %>" title="<%= Mindroute.Lemoon.Properties.Resources.Translate %>"><span class="icon-12 edit"></span></a>
          <% } else  {%>
        <a href="<%= ResolveUrl("~/admin/content/edit.aspx?id=" + item.ID) %>" title="<%= Mindroute.Lemoon.Properties.Resources.Edit %>"><span class="icon-12 edit"></span></a>
          <% }
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

<lemoon:contextmenu runat="server" />

<script type="text/javascript">
  $(document).ready(function() {
    $("#<%=phrase.ClientID %>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Filter %>");
  });
</script>
</asp:content>
