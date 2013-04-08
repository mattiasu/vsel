<%@ control language="C#" autoeventwireup="true" codebehind="Archive.ascx.cs" inherits="vsel.Lemoon.UserControls.Archive" %>

<div class="well">
  <h3><%: Resources.Strings.Archive %></h3>
  <ol class="archive unstyled">
    <% foreach (var year in List.GetYears()) {
         foreach (int month in List.GetMonths(year)) { %>
    <li>
      <a href="<%= Root.Url() + string.Format("?archive={0:0000}{1:00}", year, month) %>"><%: DateInfo.GetMonthName(month).ToTitleCase()  + " " + year%> (<%: List.GetCount(year, month) %>)</a>
    </li>
    <% }
       }%>
  </ol>
</div>
