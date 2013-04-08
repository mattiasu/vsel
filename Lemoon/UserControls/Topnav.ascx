<%@ control language="C#" autoeventwireup="true" codebehind="Topnav.ascx.cs" inherits="vsel.Lemoon.UserControls.Topnav" %>
  
<nav>
  <div class="navbar topnav">
    <div class="navbar-inner">
      <ul class="nav">
        <li <% if (Content != null && Content.ID == Start.ID) { %>class="active" <% } %>><a href="<%= Start.Url() %>"><%: Start.MenuTitle() %></a></li>
        <% foreach (var item in TopItems) { %>
        <li <% if (item.IsSelected()) { %>class="active" <% } %>>
          <a href="<%= item.Url() %>" <% if (item is Link && ((Link)item).OpenNewWindow) { %>target="_blank"<% } %>><%: item.MenuTitle()%></a>
        </li>
        <% } %>
      </ul>
      <form class="navbar-search pull-right" action="<%= Search.Url() %>">
        <input type="text" name="q" class="search-query span2" placeholder="<%: Resources.Strings.Search %>..." />
      </form>
    </div>
  </div>

  <a href="<%= Start.Url() %>"><img src="/img/logo.png" alt="logo" class="logo" /></a>

  <% if (SubItems != null) { %>
  <div class="navbar subnav">
    <ul class="nav">
      <% foreach (var item in SubItems) { %>
      <li <% if (item.IsSelected()) { %>class="active" <% } %>>
        <a href="<%= item.Url() %>" <% if (item is Link && ((Link)item).OpenNewWindow) { %>target="_blank"<% } %>><%: item.MenuTitle()%></a>
      </li>
      <% } %>
    </ul>
  </div>
  <% } %>
</nav>



