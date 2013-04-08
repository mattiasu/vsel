<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="import.aspx.cs" Inherits="Mindroute.Lemoon.Admin.Manage._User.Import" masterpagefile="~/Admin/master/main.master" enableviewstate="false" %>

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
      <col width="*" />
      <col width="250" />
      <col width="250" />
      <col width="200" />
      <thead>
        <tr>
          <th class="check">
            <input type="checkbox" id="itemselector" />
          </th>
          <th>
            <asp:localize runat="server" text="<%$ LemoonResources: Name%>" />
          </th>
          <th>
            <asp:localize runat="server" text="<%$ LemoonResources: Username%>" />
          </th>
          <th>
            <asp:localize runat="server" text="<%$ LemoonResources: Email%>" />
          </th>
          <th>
            <asp:localize runat="server" text="<%$ LemoonResources: LastSync%>" />
          </th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="5">
            <lemoon:bulkbutton id="import" runat="server" text="<%$ LemoonResources: Import%>" onclick="Import_Click" cssclass="add" />
          </td>
        </tr>
      </tfoot>
      <tbody>
        <tr id="noresult" runat="server" visible="false">
          <td colspan="5"><asp:literal id="noresulttext" runat="server" /></td>
        </tr>
        <asp:repeater id="users" runat="server">
          <itemtemplate>
            <tr>
              <td class="check">
                <input type="checkbox" name="useritem" value="<%#((Mindroute.Core.Model.User)Container.DataItem).Username %>" />
              </td>
              <td>
                <%#((Mindroute.Core.Model.User)Container.DataItem).Name %>
              </td>
              <td>  
                <%#((Mindroute.Core.Model.User)Container.DataItem).Username %>
              </td>
              <td>
                <%#((Mindroute.Core.Model.User)Container.DataItem).Email %>
              </td>
              <td>
                <%#((Mindroute.Core.Model.User)Container.DataItem).LastSync.HasValue ? ((Mindroute.Core.Model.User)Container.DataItem).LastSync.Value.ToString("d") : string.Empty%>
              </td>
            </tr>
          </itemtemplate>
          <alternatingitemtemplate>
            <tr class="alt">
              <td class="check">
                <input type="checkbox" name="useritem" value="<%#((Mindroute.Core.Model.User)Container.DataItem).Username %>" />
              </td>
              <td>
                <%#((Mindroute.Core.Model.User)Container.DataItem).Name %>
              </td>
              <td>  
                <%#((Mindroute.Core.Model.User)Container.DataItem).Username %>
              </td>
              <td>
                <%#((Mindroute.Core.Model.User)Container.DataItem).Email %>
              </td>
              <td>
                <%#((Mindroute.Core.Model.User)Container.DataItem).LastSync.HasValue ? ((Mindroute.Core.Model.User)Container.DataItem).LastSync.Value.ToString("d") : string.Empty%>
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
    <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/manage/user/" shortcut="Esc" />
  </lemoon:buttons>

  <script type="text/javascript">
    $(document).ready(function() {
      $("#<%=phrase.ClientID %>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Search %>...");
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
        $('#<%=import.ClientID %>').attr('disabled', 'disabled');
      }
      else {
        $('#<%=import.ClientID %>').removeAttr('disabled');
      }
    }
  </script>

</asp:content>
