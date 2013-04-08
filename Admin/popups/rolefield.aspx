<%@ page language="C#" masterpagefile="~/admin/master/window.master" autoeventwireup="true" codebehind="rolefield.aspx.cs" inherits="Mindroute.Lemoon.Admin.Popups.RoleField" %>
<%@ import namespace="Mindroute.Core.Model" %>

<asp:content contentplaceholderid="topmenu" runat="server">
  <span class="icon-24 role"></span>
  <%= Mindroute.Lemoon.Properties.Resources.SelectRole %>
  <div class="menu"></div>
  <form method="get">
    <% foreach (KeyValuePair<string, string> p in Params.Where(x => x.Key != "tab")) { %>  
    <input type="hidden" name="<%= p.Key %>" value="<%= p.Value %>" />
    <% } %> 
    <input id="q" type="text" name="q" value="<%= Query %>"><span class="icon-24 search"></span>
  </form>
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
<% if (Tab == "list" ) { %>
      <% if (Result.Count > 0) {%>
      <table class="details">
        <col width="200"/>
        <col width="*"/>
        <thead>
          <tr>
            <th><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
            <th><%= Mindroute.Lemoon.Properties.Resources.Description %></th>
          </tr>
        </thead>
        <tbody>
          <% int i = 0; foreach (var item in Result) { %>
          <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
            <td><a href="javascript:void(0);" onclick="<%=GetSelectScript(item) %>" <%= GetCss(item) %> title="<%= LinkToLabel %>"><span class="icon-12 role"></span><span class="title"><%= item.Name.HtmlSafe()%></span></a></td>
            <td><%= item.Description.HtmlSafe() %></td>
          </tr>
          <% } %>
        </tbody> 
      </table>
      <% } %>

<% } else if (Tab == "result") { %>

  <% if (Result.Count <= 0) {%>
  <p><%= Mindroute.Lemoon.Properties.Resources.NoResults%></p>
  <% } else {  %>
      <table class="details">
        <col width="200"/>
        <col width="*"/>
        <thead>
          <tr>
            <th><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
            <th><%= Mindroute.Lemoon.Properties.Resources.Description %></th>
          </tr>
        </thead>
        <tbody>
          <% int i = 0; foreach (var item in Result) { %>
          <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
            <td><a href="javascript:void(0);" onclick="<%=GetSelectScript(item) %>" <%= GetCss(item) %> title="<%= LinkToLabel %>"><span class="icon-12 role"></span><span class="title"><%= item.Name.HtmlSafe()%></span></a></td>
            <td><%= item.Description.HtmlSafe() %></td>
          </tr>
          <% } %>
        </tbody> 
      </table>
  <% } %>

<% } %>

  <div class="pager">
    <lemoon:pagenumbers id="pagenumbers" runat="server" />
    <lemoon:pagesizer id="pagesizer" runat="server" />
  </div>

  <div class="buttons">
    <a class="button" href="javascript:void(0);" onclick="window.close();"><span><%= Mindroute.Lemoon.Properties.Resources.Close%></span></a>
  </div>
</asp:content>
