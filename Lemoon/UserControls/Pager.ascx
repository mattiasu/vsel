<%@ control language="C#" autoeventwireup="true" codebehind="Pager.ascx.cs" inherits="vsel.Lemoon.UserControls.Pager" %>

<ul class="pager">
  <% if (Result.HasPreviousPage) { %>
  <li class="previous"><a href="<%= PrevUrl %>">Previous</a> </li>
  <% } %>
  <% if (Result.HasNextPage) { %>
  <li class="next"><a href="<%= NextUrl %>">Next</a> </li>
  <% } %>
</ul>
