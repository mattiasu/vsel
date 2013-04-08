<%@ page language="C#" masterpagefile="~/admin/master/window.master" autoeventwireup="true" codebehind="userfield.aspx.cs" inherits="Mindroute.Lemoon.Admin.Popups.UserField" %>
<%@ import namespace="Mindroute.Core.Model" %>

<asp:content contentplaceholderid="topmenu" runat="server">
  <span class="icon-24 user"></span><%= Mindroute.Lemoon.Properties.Resources.SelectUser %>
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
  <table class="list">
    <col width="250" />
    <col width="200" />
    <col width="*"/>
    <thead>
      <tr>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Username %></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Email %></th>
      </tr>
    </thead>
    <tbody>
      <% int i = 0; foreach (var item in Result) { 
            string css = i++ % 2 != 0 ? "alt" : string.Empty;
            if (!item.IsApproved) {
              css += " disabled";
            }
            css = css.RemoveDuplicateWhiteSpace();
            %>
      <tr<% if (css != null) {%> class="<%=css %>"<% } %>>
        <td class="ellipsis"><a href="javascript:void(0);" onclick="<%=GetSelectScript(item) %>" <%= GetCss(item) %> title="<%= LinkToLabel %>"><span class="icon-12 user"></span><span class="title"><%= item.DisplayName.HtmlSafe()%></span></a></td>
        <td class="ellipsis"><%=item.Username %></td>
        <td class="ellipsis"><%=item.Email %></td>
      </tr>
      <% } %>
    </tbody> 
  </table>
  <% } %>

<% } else if (Tab == "result") { %>
  <% if (Result.Count <= 0) {%>
  <p><%= Mindroute.Lemoon.Properties.Resources.NoResults%></p>
  <% } else {  %>
  <table class="list">
    <col width="250" />
    <col width="200" />
    <col width="*"/>
    <thead>
      <tr>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Username %></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Email %></th>
      </tr>
    </thead>
    <tbody>
      <% int i = 0; foreach (var item in Result) { %>
      <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
        <td class="ellipsis"><a href="javascript:void(0);" onclick="<%=GetSelectScript(item) %>" <%= GetCss(item) %> title="<%= LinkToLabel %>"><span class="icon-12 user"></span><span class="title"><%= item.DisplayName.HtmlSafe()%></span></a></td>
        <td class="ellipsis"><%=item.Username %></td>
        <td class="ellipsis"><%=item.Email %></td>
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