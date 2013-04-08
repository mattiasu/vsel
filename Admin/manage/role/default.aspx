<%@ page language="C#" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Role.Default" masterpagefile="~/admin/master/main.master" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
  <lemoon:panel runat="server" description="<%$ LemoonResources: ListRolesDescription%>">
    <div class="filter">
      <asp:textbox id="phrase" runat="server" />
    </div>  
    <table>   
      <col width="30" />
      <col width="200" />
      <col width="*" />
      <col width="95" />      
      <thead>
        <tr>
          <th class="check"><input type="checkbox" id="itemselector" /></th>
          <th><asp:localize id="name" runat="server" /></th>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Description %>" /></th>
          <th class="actions"><asp:localize runat="server" text="<%$ LemoonResources: Actions%>" /></th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="4">
            <lemoon:bulkbutton id="delete" runat="server" text="<%$ LemoonResources: DeleteSelected%>" onclick="delete_Click" cssclass="delete" enableviewstate="false" />
          </td>
        </tr>
      </tfoot>      
      <tbody>
      <asp:repeater id="roles" runat="server" onitemdatabound="Roles_ItemDataBound">
        <itemtemplate>
        <tr>
          <td class="check"><input type="checkbox" name="roleitem" value="<%#((Mindroute.Core.Model.Role)Container.DataItem).ID %>" /></td>
          <td><a id="item" runat="server" /></td>
          <td><%#((Mindroute.Core.Model.Role)Container.DataItem).Description %></td>
          <td class="actions">
            <a href="<%=ResolveUrl("~/") %>admin/manage/role/edit.aspx?gid=<%#((Mindroute.Core.Model.Role)Container.DataItem).ID %>" title="Edit role"><span class="icon-12 edit"></span></a>
            <lemoon:bulkbutton id="delete" runat="server" oncommand="delete_Command" cssclass="delete" />
          </td>
        </tr>
        </itemtemplate>
      </asp:repeater>
      </tbody>
    </table>

    <div class="pager">
      <lemoon:pagenumbers id="pagenumbers" runat="server" />
      <lemoon:pagesizer id="pagesizer" runat="server" />
    </div>

  </lemoon:panel> 
  <script type="text/javascript">
    $(document).ready(function() {
      $("tbody tr:odd").addClass("alt");
      $("#<%=phrase.ClientID %>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Filter %>");
      $("#itemselector").click(function() {
        var checked_status = this.checked;
        $("input[name=roleitem]").each(function() {
          this.checked = checked_status;
        });
        IsItemSelected();
      });
      $('input[name=roleitem]').click(function() {
        IsItemSelected();
      });
    });
    function IsItemSelected() {
      if ($('input[name=roleitem]:checked').val() == null) {
        $('#<%=delete.ClientID %>').attr('disabled', '1');
      }
      else {
        $('#<%=delete.ClientID %>').removeAttr('disabled');
      }
    }
  </script>
</asp:content>
