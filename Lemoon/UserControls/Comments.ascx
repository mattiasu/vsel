<%@ control language="C#" autoeventwireup="true" codebehind="Comments.ascx.cs" inherits="vsel.Lemoon.UserControls.Comments" %>

<h3><%: Resources.Strings.Comments %></h3>
<section id="comments">
  <ul class="unstyled striped comments" id="comments-8215">
    <% foreach (var comment in Content.Comments) { %>
    <li id="comment-<%= comment.ID %>" class="comment <%= comment.Status.ToString().ToLower() %>">
      <div class="user">
        <% if (comment.Url.IsNullOrEmpty()) { %>
        <%= GravatarHelper.Gravatar(comment.Email)%>
        <strong><%: comment.Name ?? comment.CreatedBy.DisplayName%></strong>
        <% } else {%>
        <a href="<%= comment.Url %>" rel="external nofollow"><%= GravatarHelper.Gravatar(comment.Email) %></a> 
        <strong><a href="<%= comment.Url %>" rel="external nofollow"><%: comment.Name ?? comment.CreatedBy.DisplayName%></a></strong>
        <% } %>
      </div>
      <% if (comment.Status == Mindroute.Core.Model.CommentStatus.Rejected) { %>
      <p class="text"><i><%: Resources.Strings.CommentRejected %></i></p>
      <% } else { %>
      <p class="text"><%= comment.Body.HtmlSafe(true).Linkify("nofollow")%></p>
      <% } %>
      <p><small><%: comment.Created.ToText() %></small></p>
    </li>
    <% } %>
  </ul>
  <% if (Content.Commenting == Mindroute.Core.Model.Commenting.ReadWrite) { %>
  <h4><%: Resources.Strings.WriteAComment %></h4>
  <div class="row comment-form">
    <div class="span3">
      <lemoon:textfield id="name" label="<%$ Resources: Strings, CommentName %>" required="true" runat="server" />
      <lemoon:emailfield id="email" label="<%$ Resources: Strings, CommentEmail %>" required="true" runat="server" />
      <lemoon:urlfield id="url" label="<%$ Resources: Strings, CommentUrl %>" runat="server" />
    </div>
    <div class="span6">
      <lemoon:textfield id="text" label="<%$ Resources: Strings, CommentText %>" textmode="MultiLine" required="true" runat="server" />
      <div class="actions">
        <asp:button id="submit" runat="server" text="<%$ Resources: Strings, Submit %>" onclick="Submit_Click" cssclass="btn btn-primary" />
        <asp:literal id="scri" runat="server" />
        <input type="hidden" id="chal" runat="server" />
        <input type="hidden" id="resp" runat="server" />
      </div>
    </div>
  </div>


  <% } %>
</section>
