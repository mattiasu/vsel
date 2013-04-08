<%@ control language="C#" autoeventwireup="true" codebehind="Meta.ascx.cs" inherits="vsel.Lemoon.UserControls.Meta" %>

  <meta charset="utf-8" />
  <% if (!MetaDescription.IsNullOrEmpty()) {%>
  <meta name="description" content="<%: MetaDescription %>" /><% } %>
  <% if (!MetaKeywords.IsNullOrEmpty()) {%>
  <meta name="keywords" content="<%: MetaKeywords %>" /><% } %>
  <% if (!MetaRobots.IsNullOrEmpty()) {%>
  <meta name="robots" content="<%: MetaRobots %>" /><% } %>
  <% if (!MetaSiteVerification.IsNullOrEmpty()) {%>
  <meta name="google-site-verification" content="<%: MetaSiteVerification %>" /><% } %>
