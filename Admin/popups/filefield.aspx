<%@ page language="C#" masterpagefile="~/admin/master/window.master" autoeventwireup="true" codebehind="filefield.aspx.cs" inherits="Mindroute.Lemoon.Admin.Popups.FileField" %>
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
<% if (Tab == "tree") { %>
  <div id="wrap">
    <div id="content" class="grid-9">
      <% if (Files.Count == 0) {%>
        <p><%= Mindroute.Lemoon.Properties.Resources.NoFilesFound %></p>
      <% } else { %>

        <% if (View == "details") { %>
        <table class="list">
          <col width="200" />
          <col width="*"/>
          <col width="105" />
          <col width="95" />
          <thead >
            <tr>
              <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
              <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Description %></th>
              <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Dimensions %></th>
              <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Size %></th>
            </tr>
          </thead>
          <tbody>
           <% int i = 0; foreach (var item in Files) { %>
            <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
              <td class="ellipsis"><a href="javascript:void(0);" onclick="<%=GetSelectScript(item) %>" title="<%= Mindroute.Lemoon.Properties.Resources.Insert + " " + GetLink(item) %>"><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Name.HtmlSafe()%></span></a></td>
              <td class="ellipsis"><%= item["Description"] %></td>
              <td class="actions"><%= item.Dimensions() %></td>
              <td class="actions"><%= item.Size.FileSizeAsString() %></td>
            </tr>
            <% } %>
          </tbody> 
        </table>
        <% } else { %>

        <div class="thumbs"> 
          <% foreach (var item in Files) { %>
          <%= Mindroute.Lemoon.Web.UI.Admin.HtmlFragment.Thumbnail(item, "javascript:void(0);", null, GetSelectScript(item), Mindroute.Lemoon.Properties.Resources.Insert + " " + GetLink(item), false, true, false, true, null)%>
          <% } %>
        </div>

        <% } %>
        <div class="clear"></div>

        <div class="pager">
          <lemoon:pagenumbers id="pagenumbers" runat="server" />
          <lemoon:pagesizer id="pagesizer" runat="server" />
        </div>

        <div class="buttons">
          <a class="button" href="javscript:void(0);" onclick="window.close();"><span><%= Mindroute.Lemoon.Properties.Resources.Close %></span></a>
        </div>
      <% } %>
    </div>
    <div id="aside" class="grid-3">
      <lemoon:treeview id="tree" runat="server" />
    </div>
    <div class="clear"></div>
  </div>

<% } else if (Tab == "result") { %>

  <% if (Files.Count <= 0) {%>
  <p><%= Mindroute.Lemoon.Properties.Resources.NoResults%></p>
  <% } else {  %>

  <% if (View == "details") { %>
  <table class="list">
    <col width="250" />
    <col width="*"/>
    <col width="95" />
    <col width="105" />
    <col width="95" />
    <thead >
      <tr>
        <th><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Description %></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Created %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Dimensions %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Size %></th>
      </tr>
    </thead>
    <tbody>
      <% int i = 0; foreach (var item in Files) { %>
      <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
        <td><a href="javascript:void(0);" onclick="<%=GetSelectScript(item) %>" title="<%= Mindroute.Lemoon.Properties.Resources.Insert + " " + GetLink(item) %>"><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Name.HtmlSafe()%></span></a></td>
        <td class="ellipsis"><%= item["Description"] %></td>
        <td><%= item.Created.ToText() %></td>
        <td class="actions"><%= item.Dimensions() %></td>
        <td class="actions"><%= item.Size.FileSizeAsString() %></td>
      </tr>
      <% } %>
    </tbody> 
  </table>
  <% } else {  %>
  <div class="thumbs"> 
    <% foreach (var item in Files) { %>
    <%= Mindroute.Lemoon.Web.UI.Admin.HtmlFragment.Thumbnail(item, "javascript:void(0);", null, GetSelectScript(item), Mindroute.Lemoon.Properties.Resources.Insert + " " + GetLink(item), false, true, false, true, null)%>
    <% } %>
  </div>
  <% } %>
   <div class="clear"></div>


    <div class="pager">
      <lemoon:pagenumbers id="pagenumbers2" runat="server" />
      <lemoon:pagesizer id="pagesizer2" runat="server" />
    </div>

    <div class="buttons">
      <a class="button" href="javscript:void(0);" onclick="window.close();"><span><%= Mindroute.Lemoon.Properties.Resources.Close %></span></a>
    </div>
  <% } %>

<% } else if (Tab == "upload") { %>

<lemoon:fieldset runat="server">
  <lemoon:folderfield id="destination" runat="server" label="<%$ LemoonResources: TargetFolder %>" required="true" isinnerpicker="true" />
  <lemoon:uploadfield id="file" runat="server" label="<%$ LemoonResources: UploadFile%>" required="true" />  
  <lemoon:textfield id="description" runat="server" label="<%$ LemoonResources: Description %>" />
  <lemoon:buttons runat="server">
    <lemoon:button id="upload" runat="server" text="<%$ LemoonResources: Upload %>" onclick="Upload_Click" />
  </lemoon:buttons>
  </lemoon:fieldset>

<% }  %>
</asp:content>
