<%@ page language="C#" autoeventwireup="false" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Logs.Default" masterpagefile="~/admin/master/main.master" enableeventvalidation="false" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
   


  <table>
    <col width="30" />
    <col width="*" />
    <col width="95" />
    <col width="95" />
    <col width="95" />
    <thead>
      <tr>
        <th class="check"><input type="checkbox" id="itemselector" /></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.LogFiles %> (<%= LogFiles.Count %>)</th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Modified %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Size %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Actions %></th>
      </tr>
    </thead>
    <tfoot>
      <tr>
        <td colspan="5">
          <lemoon:bulkbutton id="delete" runat="server" text="<%$ LemoonResources: DeleteSelected%>" onclick="delete_Click" cssclass="delete" enableviewstate="false" />
        </td>
      </tr>
    </tfoot> 
    <% int i = 0;
       foreach (System.IO.FileInfo file in LogFiles.OrderByDescending(x => x.LastWriteTimeUtc)) { %>
      <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
        <td class="check">
          <% if (i != 1) { %>
          <input type="checkbox" name="item" value="<%= file.Name %>" />
          <% } %>
        </td>
        <td><a href="?v=<%= Server.UrlEncode(file.Name) %>" target="_blank"><%= file.Name%></a></td>
        <td><%= file.LastWriteTimeUtc.ToText()%></td>
        <td class="actions"><%= file.Length.FileSizeAsString()%></td>
        <td class="actions">
          <a href="?d=<%= Server.UrlEncode(file.Name) %>" title="<%= Mindroute.Lemoon.Properties.Resources.Download %>" class="icon-12 download"></a>
          <a href="?v=<%= Server.UrlEncode(file.Name) %>" title="<%= Mindroute.Lemoon.Properties.Resources.Download %>" target="_blank" class="icon-12 view-preview"></a>
          <% if (i != 1) { %>
          <a href="<%= Page.ClientScript.GetPostBackClientHyperlink(this, file.Name) %>" onclick="return confirm('<%= Mindroute.Lemoon.Properties.Resources.ConfirmDeleteLog  %>');" title="<%= Mindroute.Lemoon.Properties.Resources.Delete %>" class="icon-12 delete"></a>
          <% } else { %>
          <span class="icon-12"></span>
          <% } %>
        </td>
      </tr>
    <% } %>
  </table>
  <script type="text/javascript">
    $(document).ready(function () {
      $("#itemselector").click(function () {
        var checked_status = this.checked;
        $("input[name=item]").each(function () {
          this.checked = checked_status;
        });
        IsItemSelected();
      });
      $('input[name=item]').click(function () {
        IsItemSelected();
      });
    });
    function IsItemSelected() {
      if ($('input[name=item]:checked').val() == null) {
        $('#<%=delete.ClientID %>').attr('disabled', 'disabled');
      } else {
        $('#<%=delete.ClientID %>').removeAttr('disabled');
      }
    }
  </script>



</asp:content>
