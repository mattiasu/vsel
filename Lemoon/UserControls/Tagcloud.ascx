<%@ control language="C#" autoeventwireup="true" codebehind="Tagcloud.ascx.cs" inherits="vsel.Lemoon.UserControls.Tagcloud" %>

<div class="well">
  <h3><%: Resources.Strings.Tags %></h3>
  <div class="tagcloud">
    <% foreach (var tag in Tags) { %>
    <a href="<%= Root.Url() %>?tag=<%= tag.Name %>" title="<%= tag.Count %>" style="font-size: <%= tag.Size %>px"><%: tag.Name %></a>
    <% } %>
  </div>
</div>
