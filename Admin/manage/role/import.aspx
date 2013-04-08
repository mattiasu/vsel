<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="import.aspx.cs" Inherits="Mindroute.Lemoon.Admin.Manage._Role.Import" masterpagefile="~/Admin/master/main.master" enableviewstate="false" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>
<asp:content runat="server" contentplaceholderid="content" enableviewstate="false">
  <lemoon:fieldset id="fieldset" runat="server">
    <div class="filter">
      <asp:textbox id="phrase" runat="server" />
    </div>
    <table>
      <col width="10" />
      <col width="300" />
      <col width="*" />
      <thead>
        <tr>
          <th class="check">
            <input type="checkbox" id="itemselector" />
          </th>
          <th>
            <asp:localize runat="server" text="<%$ LemoonResources: Name%>" />
          </th>
          <th>
            <asp:localize runat="server" text="<%$ LemoonResources: Description%>" />
          </th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="3">
            <lemoon:bulkbutton id="import" runat="server" text="<%$ LemoonResources: Import%>" onclick="Import_Click" cssclass="add" />
          </td>
        </tr>
      </tfoot>
      <tbody>
        <tr id="noresult" runat="server" visible="false">
          <td colspan="3"><asp:literal id="noresulttext" runat="server" /></td>
        </tr>
        <asp:repeater id="users" runat="server">
          <itemtemplate>
            <tr>
              <td class="check">
                <input type="checkbox" name="roleitem" value="<%#((Mindroute.Core.Model.Role)Container.DataItem).Guid %>" />
              </td>
              <td>
                <%#((Mindroute.Core.Model.Role)Container.DataItem).Name %>
              </td>
              <td>  
                <%#((Mindroute.Core.Model.Role)Container.DataItem).Description %>
              </td>
            </tr>
          </itemtemplate>
          <alternatingitemtemplate>
            <tr class="alt">
              <td class="check">
                <input type="checkbox" name="roleitem" value="<%#((Mindroute.Core.Model.Role)Container.DataItem).Guid %>" />
              </td>
              <td>
                <%#((Mindroute.Core.Model.Role)Container.DataItem).Name %>
              </td>
              <td>  
                <%#((Mindroute.Core.Model.Role)Container.DataItem).Description %>
              </td>
            </tr>
          </alternatingitemtemplate>
        </asp:repeater>        
      </tbody>
    </table>

    <div class="pager">
      <lemoon:pagenumbers id="pagenumbers" runat="server" />
      <lemoon:pagesizer id="pagesizer" runat="server" />
    </div>

  </lemoon:fieldset>
  <lemoon:buttons runat="server">
    <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/manage/role/" shortcut="Esc" />
  </lemoon:buttons>

  <script type="text/javascript">
    $(document).ready(function() {
      $("#<%=phrase.ClientID %>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Search %>...");
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
        $('#<%=import.ClientID %>').attr('disabled', 'disabled');
      }
      else {
        $('#<%=import.ClientID %>').removeAttr('disabled');
      }
    }
  </script>

</asp:content>
