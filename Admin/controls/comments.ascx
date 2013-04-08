<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="comments.ascx.cs" Inherits="Mindroute.Lemoon.Admin.Controls.Comments" enableviewstate="false" %>
  
<div class="filter">
  <div class="group">
    <a id="all" runat="server"><%= Mindroute.Lemoon.Properties.Resources.All%></a>
    <a id="pending" runat="server"><%= Mindroute.Lemoon.Properties.Resources.Pending%></a>
    <a id="approved" runat="server"><%= Mindroute.Lemoon.Properties.Resources.Approved%></a>
    <a id="rejected" runat="server"><%= Mindroute.Lemoon.Properties.Resources.Rejected%></a>
    <a id="flagged" runat="server"><%= Mindroute.Lemoon.Properties.Resources.Flagged%></a>
  </div>
  <div class="group">
    <a id="currentLanguage" runat="server"><%= Mindroute.Lemoon.Properties.Resources.CurrentLanguage%></a>
    <a id="allLanguages" runat="server"><%= Mindroute.Lemoon.Properties.Resources.AllLanguages%></a>
  </div>
  <asp:textbox id="phrase" runat="server" />
</div>  

<table id="comments">
<thead>
  <tr>
    <th><%= string.Format(Mindroute.Lemoon.Properties.Resources.CommentsWithCount, Items.Count) %></th>
    <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Actions %></th>
  </tr>
</thead>    
<% if (Content.Commenting == Mindroute.Core.Model.Commenting.ReadWrite) { %>
<tfoot>
  <tr class="add">
    <td colspan="2">
      <a id="addComment" runat="server"><span class="icon-12 add"></span><%= Mindroute.Lemoon.Properties.Resources.AddComment %></a>
    </td>
  </tr>
</tfoot>          
<% } %>
<tbody>
  <% int i = 0;
    foreach (Mindroute.Core.Model.Comment comment in Items) { %>
  <tr class="<%= comment.Status.ToString().ToLower() %><% if (i % 2 != 0) {%> alt<% } %>" id="c<%= comment.ID %>">
    <td class="byline"><%= Byline(comment) %></td>
    <td class="actions">
      <a href="<%= ResolveUrl("~/admin/comment/edit.aspx?id=" + comment.ContentID + "&cid=" + comment.ID)%>"><span class="icon-12 edit"></span></a>
      <a href="<%= Page.ClientScript.GetPostBackClientHyperlink(this, comment.ID+"") %>" onclick="return confirm('<%= Mindroute.Lemoon.Properties.Resources.ConfirmDeleteComment  %>');"><span class="icon-12 delete"></span></a>
    </td>
  </tr>
  <tr class="<%= comment.Status.ToString().ToLower() %><% if (i++ % 2 != 0) {%> alt<% } %>">
    <td class="text" colspan="2">
      <%= comment.Body.HtmlSafe().Linkify() %>
    </td>
  </tr>
  <% } %>
</tbody>
</table>

  <script type="text/javascript">
    $(document).ready(function () {
      $("#<%=phrase.ClientID %>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Filter %>");
    });
  </script>
