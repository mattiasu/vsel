<%@ page language="C#" masterpagefile="~/admin/master/window.master" autoeventwireup="true" codebehind="contentfield.aspx.cs" inherits="Mindroute.Lemoon.Admin.Popups.ContentField" %>
<%@ import namespace="Mindroute.Core.Model" %>

<asp:content contentplaceholderid="topmenu" runat="server">
  <span class="icon-24 site"></span>
  <%= Mindroute.Lemoon.Properties.Resources.SelectedSite %>
  <lemoon:menu id="sitemenu" runat="server" />
  <form method="get">
    <% foreach (KeyValuePair<string, string> p in Params.Where(x => x.Key != "tab")) { %>  
    <input type="hidden" name="<%= p.Key %>" value="<%= p.Value %>" />
    <% } %> 
    <input id="q" type="text" name="q" value="<%= Query %>"><span class="icon-24 search"></span>
  </form>
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
<% if (Tab == "tree" ) { %>
  <div id="wrap">
    <div id="content" class="grid-9">

      <div class="head">
        <% if (SelectedContent != null) { %>
          <h1><%= SelectedContent.Title.HtmlSafe() %></h1>
          <div class="permalink"><%= GetUrl(SelectedContent) %></div>
          <p class="teaser"><%= SelectedContent.Teaser %></p>
          <div class="buttons">
            <a class="button" href="javascript:void(0);" onclick="<%=GetSelectScript(SelectedContent) %>"><span><%= LinkToLabel%></span></a>
            <div class="separator"><%= Mindroute.Lemoon.Properties.Resources.ButtonsOr %></div>
            <a class="link" href="javscript:void(0);" onclick="window.close();"><%= Mindroute.Lemoon.Properties.Resources.Close %></a>
          </div>
        <% } else {
             var s = GetSiteForSelectScript(); %>
          <h1><%= s.Title.HtmlSafe() %></h1>
          <div class="permalink"><%= s.Url()%></div>
          <p class="teaser"><%= s.Teaser%></p>
          <% if (IsSitePicker) { %>
          <div class="buttons">
            <a class="button" href="javascript:void(0);" onclick="<%=GetSelectScript(s) %>"><span><%= LinkToLabel %></span></a>
            <div class="separator"><%= Mindroute.Lemoon.Properties.Resources.ButtonsOr %></div>
            <a class="link" href="javscript:void(0);" onclick="window.close();"><%= Mindroute.Lemoon.Properties.Resources.Close %></a>
          </div>       
        <%  }
          } %>
        </div>

        <% if (Result.Count > 0) {%>
        <table class="list">
          <col width="200" />
          <col width="*"/>
          <thead>
            <tr>
              <th><%= Mindroute.Lemoon.Properties.Resources.Children %></th>
              <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Teaser%></th>
            </tr>
          </thead>
          <tbody>
           <% int i = 0; foreach (var item in Result) { %>
            <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
              <td><a href="javascript:void(0);" onclick="<%=GetSelectScript(item) %>" <%= GetCss(item) %> title="<%= LinkToLabel %>"><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Title.HtmlSafe()%></span></a></td>
              <td class="ellipsis"><%= item.Teaser%></td>
            </tr>
            <% } %>
          </tbody> 
        </table>
        <% } %>

       <div class="pager">
        <lemoon:pagenumbers id="pagenumbers" runat="server" />
        <lemoon:pagesizer id="pagesizer" runat="server" />
      </div>
    </div>
    <div id="aside" class="grid-3">
      <lemoon:treeview id="tree" runat="server" />
    </div>
    <div class="clear"></div>
  </div>

<% } else if (Tab == "result") { %>

  <% if (Result.Count <= 0) {%>
  <p><%= Mindroute.Lemoon.Properties.Resources.NoResults%></p>
  <% } else {  %>
  <table class="list">
    <col width="200" />
    <col width="*"/>
    <thead>
      <tr>
        <th><%= IsFolderPicker ? Mindroute.Lemoon.Properties.Resources.Folder : Mindroute.Lemoon.Properties.Resources.Title %></th>
        <th class="ellipsis"><%= IsFolderPicker ? Mindroute.Lemoon.Properties.Resources.Description : Mindroute.Lemoon.Properties.Resources.Teaser %></th>
      </tr>
    </thead>
    <tbody>
      <% int i = 0; foreach (var item in Result) { %>
      <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
        <td><a href="javascript:void(0);" onclick="<%=GetSelectScript(item) %>" <%= GetCss(item) %> title="<%= LinkToLabel %>"><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Title.HtmlSafe()%></span></a></td>
        <td><%= IsFolderPicker ? ((string)item["Description"]).HtmlSafe() : item.Teaser %></td>
      </tr>
      <% } %>
    </tbody> 
  </table>

  <div class="pager">
    <lemoon:pagenumbers id="pagenumbers2" runat="server" />
    <lemoon:pagesizer id="pagesizer2" runat="server" />
  </div>

  <div class="buttons">
    <a class="button" href="javscript:void(0);" onclick="window.close();"><span><%= Mindroute.Lemoon.Properties.Resources.Close %></span></a>
  </div>
  <% } %>

<% } %>



</asp:content>
