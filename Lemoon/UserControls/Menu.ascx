<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="vsel.Lemoon.UserControls.Menu" %>

<ul class="nav-bar right">
    <li <% if (Content != null && Content.ID == Start.ID) { %>class="active" <% } %>><a href="<%= Start.Url() %>"><%: Start.MenuTitle() %></a></li>
        <% foreach (var item in TopItems) { %>
        <li <% if (item.IsSelected()) { %>class="active" <% } %>>
          <a href="<%= item.Url() %>" <% if (item is Link && ((Link)item).OpenNewWindow) { %>target="_blank"<% } %>><%: item.MenuTitle()%></a>
        </li>
        <% } %>
    
    <!--<li><a href="/">Start</a></li>    -->
</ul>

