<%@ control language="C#" autoeventwireup="true" codebehind="Feeds.ascx.cs" inherits="vsel.Lemoon.UserControls.Feeds" %>

<% foreach (var feedtype in Content.Feeds()) {%>
  <link href="<%= Content.FeedUrl(feedtype) %>" rel="alternate" type="application/<%= Content.FeedFormat() %>+xml" title="<%: GetTitle(feedtype) %>" />     
<% } %>