<%@ page language="C#" masterpagefile="~/admin/master/window.master" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.TinyMCE.Plugins.LemoonLink.Default" %>
<%@ import namespace="Mindroute.Core.Model" %>

<asp:content contentplaceholderid="head" runat="server">
  <link type="text/css" href="css/lemoonlink.css" rel="stylesheet" media="screen" />
  <script type="text/javascript" src="../../tiny_mce_popup.js"></script>
  <script type="text/javascript" src="../../utils/validate.js"></script>
  <script type="text/javascript" src="../../utils/form_utils.js"></script>
  <script type="text/javascript" src="js/lemoonlink.js"></script>
</asp:content>

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
<% if (Tab == "site" || Tab == "files") { %>
  <div id="wrap">
    <div id="content" class="grid-9">
      <% if (Tab == "files" && View == "details") { %>
          
        <% if (Files.Count > 0) { %>
        <table class="details">
          <col width="200" />
          <col width="*"/>
          <col width="95" />
          <col width="95" />
          <thead>
            <tr>
              <th><%= Mindroute.Lemoon.Properties.Resources.Name%></th>
              <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Description%></th>
              <th><%= Mindroute.Lemoon.Properties.Resources.Created%></th>
              <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Size%></th>
            </tr>
          </thead>
          <tbody>
            <% int i = 0; foreach (Document item in Files) { %>
            <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
              <td><a href="default.aspx?<%= ToQueryString(Params.Where(x => x.Key != "href" && x.Key != "tab"), "href", GetLink(item)) %>"<%= GetCss(item) %> title="<%= Mindroute.Lemoon.Properties.Resources.LinkToFile %>"><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Title.HtmlSafe()%></span></a> </td>
              <td class="ellipsis"><%= item["Description"]%></td>
              <td><%= item.Created.ToText()%></td>
              <td class="actions"><%= item.Size.FileSizeAsString()%></td>
            </tr>
            <% } %>
          </tbody> 
        </table>
        <% } %>

      <% } else if (Tab == "files") { %>
        
        <% if (Files.Count > 0) {%>
        <div class="thumbs">
          <% foreach (Document item in Files) { %>
          <%= Mindroute.Lemoon.Web.UI.Admin.HtmlFragment.Thumbnail(item, "default.aspx?" + ToQueryString(Params.Where(x => x.Key != "href" && x.Key != "tab"), "href", GetLink(item)), null, null, Mindroute.Lemoon.Properties.Resources.LinkToFile, false, true, false, true, null)%>
          <% } %>
       </div>
        <% } %>
        

      <% } else { %>

      <div class="head">
        <% if (SelectedContent != null) { %>
          <h1><%= SelectedContent.Title.HtmlSafe() %></h1>
          <div class="permalink"><%= GetUrl(SelectedContent) %></div>
          <p class="teaser"><%= SelectedContent.Teaser %></p>
          <div class="buttons">
            <a class="button" href="default.aspx?<%= ToQueryString(Params.Where(x => x.Key != "href" && x.Key != "tab"), "href", GetLink(SelectedContent)) %>"><span><%= Mindroute.Lemoon.Properties.Resources.LinkToPage %></span></a>
          </div>
        <% } else { %>
          <h1><%= SelectedSite.Title.HtmlSafe() %></h1>
          <div class="permalink"><%= SelectedSite.Url()%></div>
          <p class="teaser"><%= SelectedSite.Teaser%></p>
          <div class="buttons">
            <a class="button" href="default.aspx?<%= ToQueryString(Params.Where(x => x.Key != "href" && x.Key != "tab"), "href", SelectedSite.Url()) %>"><span><%= Mindroute.Lemoon.Properties.Resources.LinkToSite %></span></a>
          </div>       
        <% } %>
        </div>

        <% if (Result.Count > 0) {%>
        <table class="details">
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
              <td><a href="default.aspx?<%= ToQueryString(Params.Where(x => x.Key != "href" && x.Key != "tab"), "href", GetLink(item)) %>"<%= GetCss(item) %> title="<%= Mindroute.Lemoon.Properties.Resources.LinkToPage %>"><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Title.HtmlSafe()%></span></a></td>
              <td class="ellipsis"><%= item.Teaser%></td>
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
  <table class="details">
    <col width="200" />
    <col width="*"/>
    <thead>
      <tr>
        <th><%= Mindroute.Lemoon.Properties.Resources.Title %></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Teaser%></th>
      </tr>
    </thead>
    <tbody>
      <% int i = 0; foreach (var item in Result) { %>
      <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
        <td><a href="default.aspx?<%= ToQueryString(Params.Where(x => x.Key != "href" && x.Key != "tab"), "href", GetLink(item)) %>"<%= GetCss(item) %> title="<%= Mindroute.Lemoon.Properties.Resources.LinkToPage %>"><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Title.HtmlSafe()%></span></a></td>
        <td class="ellipsis"><%= item.Teaser%></td>
      </tr>
      <% } %>
    </tbody> 
  </table>

  <div class="pager">
    <lemoon:pagenumbers id="pagenumbers2" runat="server" />
    <lemoon:pagesizer id="pagesizer2" runat="server" />
  </div>

  <% } %>

<% } else { %>
  <div class="field">
    <label for="href"><%= Mindroute.Lemoon.Properties.Resources.Url %></label>
    <input id="href" name="href" type="text" value="<%= Href %>" />
  </div>
  <div class="field" id="anchorContainer" style="display:none;">
    <label for="anchorlist"><%= Mindroute.Lemoon.Properties.Resources.Anchors %></label>
    <select id="anchorlist" name="anchorlist" class="mceAnchorList" onchange="this.form.href.value=this.options[this.selectedIndex].value;"></select>
  </div>
  <div class="field">
    <label for="title"><%= Mindroute.Lemoon.Properties.Resources.LinkTitle %></label>
    <input id="title" name="title" type="text" value="<%= LinkTitle %>" />
  </div>
  <div class="field">
    <label for="class"><%= Mindroute.Lemoon.Properties.Resources.CssClass %></label>
    <input id="class" name="class" type="text" value="<%= Class %>" />
  </div>
  <div class="field">
    <span class="checkbox">
      <input type="checkbox" id="target" <% if (Target == "_blank") { %>checked="checked" <% } %>/>
      <label for="target"><%= Mindroute.Lemoon.Properties.Resources.LinkTargetBlank %></label>
    </span>
  </div>
  <div class="buttons">
    <a class="button" onclick="LemoonLinkDialog.InsertAction();" href="javascript:void(0);"><span><%= Action == "update" ? Mindroute.Lemoon.Properties.Resources.Update : Mindroute.Lemoon.Properties.Resources.Insert %></span></a>
    <div class="separator"><%= Mindroute.Lemoon.Properties.Resources.ButtonsOr %></div>
    <a class="link" onclick="LemoonLinkDialog.Close();" href="javascript:void(0);"><%= Mindroute.Lemoon.Properties.Resources.Cancel %></a>
  </div>
<% } %>
</asp:content>
