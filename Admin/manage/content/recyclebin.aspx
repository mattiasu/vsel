<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="recyclebin.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Content.RecycleBin" masterpagefile="~/admin/master/main.master" enableviewstate="false"  %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
  <p><asp:localize runat="server" text="<%$ LemoonResources: RecycleBinDescription%>" /></p>  
  <div class="filter">
    <div class="group">
      <a id="searchAllTypes" runat="server"><%= Mindroute.Lemoon.Properties.Resources.All%></a>
      <a id="searchContent" runat="server"><%= Mindroute.Lemoon.Properties.Resources.Site%></a>
      <a id="searchFiles" runat="server"><%= Mindroute.Lemoon.Properties.Resources.Files%></a>
    </div>
    <div class="group">
      <a id="searchAllSites" runat="server"><%= Mindroute.Lemoon.Properties.Resources.AllSites%></a>
      <a id="searchCurrentSite" runat="server"><%= Mindroute.Lemoon.Properties.Resources.CurrentSite%></a>
    </div>
    <asp:textbox id="phrase" runat="server" />
  </div>
  <table>
    <col width="30" />
    <col width="*" />
    <col width="200" />
    <col width="95" />
    <col width="95" />
    <thead>
      <tr>
        <th class="check"><input type="checkbox" id="itemselector" /></th>
        <th><asp:localize id="name" runat="server" text="<%$ LemoonResources: Name%>" /></th>
        <th><asp:localize runat="server" text="<%$ LemoonResources: DeletedBy%>" /></th>
        <th><asp:localize runat="server" text="<%$ LemoonResources: DeletedDate%>" /></th>
        <th class="actions"><asp:localize runat="server" text="<%$ LemoonResources: Actions%>" /></th>
      </tr>
    </thead>
    <tfoot>
      <tr>
        <td colspan="5">
          <lemoon:bulkbutton id="restore" runat="server" text="<%$ LemoonResources: RestoreSelected%>" onclick="restore_Click" cssclass="restore" />, 
          <lemoon:bulkbutton id="delete" runat="server" text="<%$ LemoonResources: DeleteSelected%>" onclick="delete_Click" cssclass="delete" />
        </td>
      </tr>
    </tfoot>          
    <tbody>
      <asp:repeater id="content" runat="server" onitemdatabound="content_ItemDataBound">
        <itemtemplate>
          <tr>
            <td class="check"><input type="checkbox" name="item" id="item<%#((Mindroute.Core.Model.Content)Container.DataItem).ID%>" value="<%#((Mindroute.Core.Model.Content)Container.DataItem).ID%>" /></td>
            <td><label for="file<%#((Mindroute.Core.Model.Content)Container.DataItem).ID%>"><%#((Mindroute.Core.Model.Content)Container.DataItem).Title%></label></td>
            <td id="deletedby" runat="server"></td>
            <td id="deleteddate" runat="server"></td>
            <td class="actions">
              <lemoon:bulkbutton id="restore" runat="server" tooltip="<%$ LemoonResources: Restore %>" onclick="restoreItem_Click" cssclass="restore" />
              <lemoon:bulkbutton id="delete" runat="server" tooltip="<%$ LemoonResources: Delete %>" onclick="deleteItem_Click" cssclass="delete" />
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

  <lemoon:fieldset runat="server" vertical="true">
    <lemoon:buttons runat="server">
      <lemoon:button id="empty" runat="server" text="<%$ LemoonResources: EmptyRecycleBin%>" onclick="empty_Click" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" href="~/admin/manage/" />
    </lemoon:buttons>    
  </lemoon:fieldset>
  <script type="text/javascript">
    $(document).ready(function() {
      $("tbody tr:odd").addClass("alt");
      $("#<%=phrase.ClientID %>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Filter %>");
      $("#itemselector").click(function() {
        var checked_status = this.checked;
        $("input[name=item]").each(function() {
          this.checked = checked_status;
        });
        IsItemSelected();
      });
      $('input[name=item]').click(function() {
        IsItemSelected();
      });
    });
    function IsItemSelected() {
      if ($('input[name=item]:checked').val() == null) {
        $('#<%=delete.ClientID %>').attr('disabled', '1');
        $('#<%=restore.ClientID %>').attr('disabled', '1');
      }
      else {
        $('#<%=delete.ClientID %>').removeAttr('disabled');
        $('#<%=restore.ClientID %>').removeAttr('disabled');
      }
    }
  </script>
</asp:content>
