<%@ page language="C#" autoeventwireup="false" codebehind="list.aspx.cs" inherits="Mindroute.Lemoon.Admin._File.List" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
  <div class="filter">
    <div class="group">
      <a id="g" runat="server"><%= Mindroute.Lemoon.Properties.Resources.All%></a>
      <a id="p" runat="server"><%= Mindroute.Lemoon.Properties.Resources.Published%></a>
      <a id="u" runat="server"><%= Mindroute.Lemoon.Properties.Resources.UnPublished%></a>
    </div>
    <asp:dropdownlist id="ctList" runat="server" />
    <asp:textbox id="phrase" runat="server" />
  </div>  

  <div id="detailedView" runat="server">
    <table class="list">
      <col width="30" />            
      <col width="250" />
      <col width="200" />
      <col width="*" />
      <col width="95" />
      <col width="105" />
      <col width="95" />
      <col width="95" />
      <thead>
        <tr>
          <th class="check"><input type="checkbox" id="fileselector" /></th>
          <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Files %> (<%= Result.TotalItemCount %>)</th>
          <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Folder %></th>
          <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Description %></th>
          <th><%= Mindroute.Lemoon.Properties.Resources.Created %></th>
          <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Dimensions %></th>
          <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Size %></th>
          <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Actions %></th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="8">
            <lemoon:bulklink id="move" runat="server" text="<%$ LemoonResources: MoveSelected%>" cssclass="move" enableviewstate="false" onclick="return MoveSelected();" href="javascript:void(0);"  />,
            <lemoon:bulkbutton id="delete" runat="server" text="<%$ LemoonResources: TrashSelected%>" cssclass="recycle-bin" enableviewstate="false" onclientclick="return DeleteSelected();" />
          </td>
        </tr>            
      </tfoot>
      <tbody>
      <% if (Result.Count == 0) {%>
      <tr>
        <td colspan="8">
          <%= Mindroute.Lemoon.Properties.Resources.NoResults %>
        </td>
      </tr>
      <% } %>

      <% 
        int i = 0; 
        foreach (var item in Result) {
          string disabled = string.Empty;
          if (!PermissionService.HasPermission(Mindroute.Core.Security.EntityType.Content, item.ID, Mindroute.Core.Security.AccessMask.Delete)) {
            disabled = @" disabled=""disabled""";
          }
       %>
        <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
          <td class="check"><input type="checkbox" name="fileitem" id="file<%=item.ID%>" value="<%=item.ID%>"<%=disabled %> /></td>
          <td class="ellipsis ctmenu">
            <a href="<%= ResolveUrl("~/admin/file/edit.aspx?id=") + item.ID %>" data-id="<%=item.ID %>"><%= item.MenuTitle().HtmlSafe() + (item.LanguageID == Site.LanguageID ? "" : "  [" + item.Site.LanguageCode + "]") %></a>
          </td>
          <td class="ellipsis"><% if (item.Parent != null) { %>
            <a href="<%= ResolveUrl("~/admin/file/default.aspx?id=") + item.ParentID + "&tab=tree" %>"<%= GetTitle(item.Parent) %>><%= item.Parent.MenuTitle().HtmlSafe() + (item.Parent.LanguageID == Site.LanguageID ? "" : "  [" + item.Parent.Site.LanguageCode + "]") %></a>
            <% } %>
          </td>
          <td class="ellipsis"><%= item.Description.HtmlSafe() %></td>
          <td><%= item.Created.ToText()%></td>
          <td class="actions"><%= item.Dimensions()%></td>
          <td class="actions"><%= item.Size.FileSizeAsString()%></td>
          <td class="actions">
            <% if (HasEdit(item)) { %>
            <a href="<%= ResolveUrl("~/admin/file/edit.aspx?id=") + item.ID %>" title="<%= Mindroute.Lemoon.Properties.Resources.Edit %>"><span class="icon-12 edit"></span></a>
            <% } %>
            <a href="<%= GetUrl(item) %>?download=0" title="<%= Mindroute.Lemoon.Properties.Resources.Download %>" class="icon-12 download"></a>
            <a href="<%= GetUrl(item) %>" title="<%= Mindroute.Lemoon.Properties.Resources.View %>" target="_blank" class="icon-12 view-preview"></a>
            <% if (HasDelete(item)) { %>
            <a href="javascript:void(0);" title="<%= Mindroute.Lemoon.Properties.Resources.Trash %>" onclick="if (!window.confirm('<%= Mindroute.Lemoon.Properties.Resources.ConfirmTrashFile %>')) { return false; } else { Lemoon.DeleteContent(<%= item.ID %>, '<%= ResolveUrl("~/admin/file/list.aspx") %>') }"><span class="icon-12 recycle-bin"></span></a>
            <% } %>
          </td>
        </tr>
      <% } %>
      </tbody>
    </table>
  </div>

  <div id="thumbnailView" runat="server">
    <div class="thumbs">
    <% foreach (var item in Result) { %>
      <%= Mindroute.Lemoon.Web.UI.Admin.HtmlFragment.Thumbnail(item as Mindroute.Core.Model.Document, PermissionService.HasPermission(Mindroute.Core.Security.EntityType.Content, item.ID, Mindroute.Core.Security.AccessMask.Edit) ? ResolveUrl("~/admin/file/edit.aspx?id=") + item.ID : null, null, null, null, true, true, true, true, ResolveUrl("~/admin/file/list.aspx"))%>
    <% } %>
    </div>
  </div>

  <div class="pager">
    <lemoon:pagenumbers id="pagenumbers" runat="server" />
    <lemoon:pagesizer id="pagesizer" runat="server" />
  </div>

  <lemoon:contextmenu  runat="server" type="file" />

  <script type="text/javascript">
    $(document).ready(function () {
      $("#<%=phrase.ClientID %>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Filter %>");
      $("#fileselector").click(function () {
        var checked_status = this.checked;
        $("input[name=fileitem]").each(function () {
          if (!$(this).attr('disabled')) {
            this.checked = checked_status;
          }
        });
        VerifyIfFilesAreSelected();
      });
      $('input[name=fileitem]').click(function () {
        VerifyIfFilesAreSelected();
      });
    });
    function DeleteSelected() {    
      if (!window.confirm('<%=Mindroute.Lemoon.Properties.Resources.ConfirmTrashSelectedFiles %>')) {
        return false;
      }
      
      var values = [];
      $('input[name=fileitem]:checked').each(function() {
        values.push($(this).val());
      });
      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "<%=ResolveUrl("~/") %>admin/api/content/delete?contentID=0&bulk=" + values.toString(),
        dataType: "json",
        cache: false,
        error: function(XMLHttpRequest, textStatus, errorThrown) {
          alert(textStatus);
        },
        success: function(data, textStatus) {
          if (data.Status == "error") {
            alert(data.Message);
          } else {
            location.href = '<%=ResolveUrl("~/admin/file/list.aspx")%>';
          }
        }
      });
      return false;
    }

    function MoveSelected() {
      var values = [];
      $('input[name=fileitem]:checked').each(function() {
        values.push($(this).val());
      });
      window.location.href = '<%=_moveUrl%>&bulk=' + values.toString();
      return false;
    }    
    
    function VerifyIfFilesAreSelected() {
      if ($('input[name=fileitem]:checked').val() == null) {
        $('#<%=delete.ClientID%>').attr('disabled', '1');
        $('#<%=move.ClientID%>').attr('disabled', '1');
      }
      else {
        $('#<%=delete.ClientID%>').removeAttr('disabled');
        $('#<%=move.ClientID%>').removeAttr('disabled');
      }
    }
  </script>
</asp:content>
