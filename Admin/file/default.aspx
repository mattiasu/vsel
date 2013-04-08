<%@ page title="" language="C#" masterpagefile="~/admin/master/main.master" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin._File.Default" enableviewstate="false"  %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:filemenu runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <div id="wrap">
    <div id="content" class="grid-9">
             
      <div id="detailedView" runat="server">

        <table id="list" style="table-layout:fixed;">
          <col width="30" />            
          <col width="250" />
          <col width="*" />
          <col width="95" />
          <col width="105" />
          <col width="95" />
          <col width="95" />
          <thead id="head" runat="server">
            <tr>
              <th class="check"><input type="checkbox" id="fileselector" /></th>
              <th><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
              <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Description %></th>
              <th><%= Mindroute.Lemoon.Properties.Resources.Created %></th>
              <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Dimensions %></th>
              <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Size %></th>
              <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Actions %></th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <td colspan="7">
                <lemoon:bulklink id="move" runat="server" text="<%$ LemoonResources: MoveSelected%>" cssclass="move" enableviewstate="false" onclick="return MoveSelected();" href="javascript:void(0);" />,
                <lemoon:bulkbutton id="delete" runat="server" text="<%$ LemoonResources: TrashSelected%>" cssclass="recycle-bin" enableviewstate="false" onclientclick="return DeleteSelected();" />
              </td>
            </tr>              
          </tfoot>
          <tbody>
        <asp:repeater id="files" runat="server" onitemdatabound="files_ItemDataBound">
          <itemtemplate>
            <tr<%# (Container.ItemIndex % 2 == 0) ? "" : " class=\"alt\"" %>>
              <td class="check"><input type="checkbox" name="fileitem" id="file<%#((Mindroute.Core.Model.Content)Container.DataItem).ID%>" value="<%#((Mindroute.Core.Model.Content)Container.DataItem).ID%>" /></td>
              <td class="ellipsis ctmenu"><a id="edit" runat="server" data-id="<%#((Mindroute.Core.Model.Content)Container.DataItem).ID%>"><%#((Mindroute.Core.Model.Content)Container.DataItem).Title %></a></td>
              <td class="ellipsis"><%#((Mindroute.Core.Model.Document)Container.DataItem).Description %></td>
              <td id="createddate" runat="server"></td>
              <td class="actions" id="dim" runat="server"></td>
              <td class="actions" id="size" runat="server"></td>
              <td class="actions">
                <a id="editIcon" runat="server"><span class="icon-12 edit"></span></a>
                <a href="<%# GetUrl(Container.DataItem as Mindroute.Core.Model.Content) %>?download=1" title="<%= Mindroute.Lemoon.Properties.Resources.Download %>" class="icon-12 download"></a>
                <a href="<%# GetUrl(Container.DataItem as Mindroute.Core.Model.Content) %>" title="<%=Mindroute.Lemoon.Properties.Resources.View %>" target="_blank" class="icon-12 view-preview"></a>
                <a id="delete" runat="server"><span class="icon-12 recycle-bin"></span></a> 
              </td>
            </tr>
          </itemtemplate>
        </asp:repeater>
          </tbody> 
        </table>
      </div>

      <div id="thumbnailView" runat="server">
        <div class="thumbs">
        <% foreach (var item in Files) { %>
          <%= Mindroute.Lemoon.Web.UI.Admin.HtmlFragment.Thumbnail(item as Mindroute.Core.Model.Document, PermissionService.HasPermission(Mindroute.Core.Security.EntityType.Content, item.ID, Mindroute.Core.Security.AccessMask.Edit) ? ResolveUrl("~/admin/file/edit.aspx?id=") + item.ID : null, null, null, null, true, true, true, true, _returnUrl)%>
        <% } %>
        </div>
      </div>

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

  <lemoon:contextmenu runat="server" type="folder" />
  <lemoon:contextmenu runat="server" type="file" />

  <script type="text/javascript">
    $(document).ready(function() {
      $("#fileselector").click(function() {
        var checked_status = this.checked;
        $("input[name=fileitem]").each(function() {
          this.checked = checked_status;
        });
        VerifyIfFilesAreSelected();
      });
      $('input[name=fileitem]').click(function() {
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
            location.href = '<%=_returnUrl%>';
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
    function deleteContent(contentID, returnUrl) {
      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: Lemoon.RootUrl() + "admin/api/content/delete?contentID=" + contentID,
        dataType: "json",
        cache: false,
        error: function(XMLHttpRequest, textStatus, errorThrown) {
          alert(textStatus);
        },
        success: function(data, textStatus) {
          if (data.Status == "error") {
            alert(data.Message);
          } else {
            location.href = returnUrl;
          }
        }
      });
    }    
  </script>
</asp:content>
