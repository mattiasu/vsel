<%@ page language="C#" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._User.Default" masterpagefile="~/admin/master/main.master" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">

  <lemoon:panel runat="server" description="<%$ LemoonResources: ListUsersDescription%>">
    <div class="filter">
      <div class="group">
        <a id="searchAll" runat="server" class="selected"><asp:localize runat="server" text="<%$ LemoonResources: All%>" /></a> 
        <a id="searchEnabled" runat="server"><asp:localize runat="server" text="<%$ LemoonResources: Enabled%>" /></a> 
        <a id="searchDisabled" runat="server"><asp:localize runat="server" text="<%$ LemoonResources: Disabled%>" /></a>  
        <a id="searchDeleted" runat="server"><asp:localize runat="server" text="<%$ LemoonResources: Deleted%>" /></a>
      </div>
      <asp:textbox id="phrase" runat="server" />
    </div>
    
    <table class="list">   
      <col width="30" />
      <col width="250" />
      <col width="200" />
      <col width="*" />
      <col width="95" />   
      <thead>
        <tr>
          <th class="check"><input type="checkbox" id="itemselector" /></th>
          <th class="ellipsis"><asp:localize id="name" runat="server" /></th>
          <th class="ellipsis"><asp:localize runat="server" text="<%$ LemoonResources: Username%>" /></th>
          <th class="ellipsis"><asp:localize runat="server" text="<%$ LemoonResources: Email%>" /></th>
          <th class="actions"><asp:localize runat="server" text="<%$ LemoonResources: Actions%>" /></th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="5">
            <lemoon:bulkbutton id="delete" runat="server" text="<%$ LemoonResources: DeleteSelected%>" onclick="delete_Click" cssclass="delete" enableviewstate="false" />
          </td>
        </tr>
      </tfoot>      
      <tbody>
      <asp:repeater id="users" runat="server" onitemdatabound="Users_ItemDataBound">
        <itemtemplate>
        <tr>
          <td class="check"><input type="checkbox" name="useritem" value="<%#((Mindroute.Core.Model.User)Container.DataItem).ID %>" /></td>
          <td class="ellipsis"><a id="item" runat="server" /></td>
          <td class="ellipsis"><%#((Mindroute.Core.Model.User)Container.DataItem).Username %></td>
          <td class="ellipsis"><%#((Mindroute.Core.Model.User)Container.DataItem).Email %></td>
          <td class="actions">
            <a href="<%=ResolveUrl("~/") %>admin/manage/user/edit.aspx?uid=<%#((Mindroute.Core.Model.User)Container.DataItem).ID %>" title="Edit user"><span class="icon-12 edit"></span></a> 
            <lemoon:bulkbutton id="changestate" runat="server" onclick="changeState_Click" />
            <lemoon:bulkbutton id="delete" runat="server" oncommand="delete_Command" />
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
        $("input[name=useritem]").each(function() {
          this.checked = checked_status;
        });
        IsItemSelected();
      });
      $('input[name=useritem]').click(function() {
        IsItemSelected();
      });
    });
    function IsItemSelected() {
      if ($('input[name=useritem]:checked').val() == null) {
        $('#<%=delete.ClientID %>').attr('disabled', '1');
      }
      else {
        $('#<%=delete.ClientID %>').removeAttr('disabled');
      }
    }
  </script>

</asp:content>
