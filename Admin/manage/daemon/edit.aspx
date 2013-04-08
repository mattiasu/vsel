<%@ page language="C#" autoeventwireup="True" codebehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Daemon.Edit" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ import namespace="Mindroute.Core.Helpers" %>

<asp:content id="Content1" contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu id="Managemenu1" runat="server" />
</asp:content>

<asp:content id="Content2" contentplaceholderid="content" runat="server">

  <lemoon:fieldset runat="server" id="properties">
    <lemoon:labelfield id="name" runat="server" label="<%$ LemoonResources: Name%>" />
    <lemoon:labelfield id="description" runat="server" label="<%$ LemoonResources: Description%>" /> 
    <asp:placeholder id="labelControls" runat="server" />
    <lemoon:booleanfield id="enabled" runat="server" label="<%$ LemoonResources: Enabled %>" />
  </lemoon:fieldset>

  <lemoon:fieldset id="settings" runat="server" enabled="false" visible="false">
    <asp:placeholder id="editControls" runat="server" />
  </lemoon:fieldset>   

  <fieldset class="tab" id="queue" runat="server" visible="false">

    <div class="filter">
      <div class="group">
        <a id="all" runat="server" class="selected"><asp:localize runat="server" text="<%$ LemoonResources: All%>" /></a>
        <a id="pending" runat="server"><asp:localize runat="server" text="<%$ LemoonResources: Pending%>" /></a>
        <a id="working" runat="server"><asp:localize runat="server" text="<%$ LemoonResources: Working%>" /></a>
        <a id="finished" runat="server"><asp:localize runat="server" text="<%$ LemoonResources: Finished%>" /></a>
      </div>
    </div>

    <table class="list">
      <col width="30" />
      <col width="*" />
      <col width="250" />
      <col width="95" />
      <col width="95" />
      <col width="95" />
      <col width="95" />
    <thead>
      <tr>
        <th class="check"><input type="checkbox" id="itemselector" /></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Payload %></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Job_Message %></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Job_Created %></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Job_Started %></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Job_Finished %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Actions %></th>
      </tr>
    </thead>
    <tfoot>
      <tr>
        <td colspan="7">
          <a id="delete" href="<%= GetRemoveSelectedLink() %>;" disabled="disabled"><span class="icon-12 delete"></span><%=  Mindroute.Lemoon.Properties.Resources.DeleteSelected %></a>
        </td>
      </tr>
    </tfoot>  
    <tbody>
      <% if (Jobs.Count == 0) {%>
      <tr>
        <td colspan="7">
          <%= Mindroute.Lemoon.Properties.Resources.NoResults %>
        </td>
      </tr>
      <% } %>

      <% int i = 0; foreach (var item in Jobs) {
           string css = i++ % 2 == 0 ? string.Empty : "alt";
           if (item.Errors > 0) {
             css += " error";
           } %>
        <tr class="<%= css.Trim() %>">
          <td class="check"><input type="checkbox" name="jobitem" value="<%= item.ID %>" /></td>
          <td class="ellipsis"><%= item.Payload.ToString().StripHtml() %></td>
          <td class="ellipsis" title="<%= item.Message.StripHtml() %>"><%= item.Message.StripHtml() %></td>
          <td><%= item.Created.ToText()%></td>
          <td><%= item.Started.ToText()%></td>
          <td><%= item.Finished.ToText()%></td>
          <td class="actions">
            <% if (item.Status == Mindroute.Core.Model.JobStatus.Finished) { %>
            <a href="<%= GetResetLink(item) %>;" title="<%= Mindroute.Lemoon.Properties.Resources.Reset %>" class="icon-12 restore" ></a>
            <% } %>
            <a href="<%= GetRemoveLink(item) %>;" title="<%= Mindroute.Lemoon.Properties.Resources.Delete %>" class="icon-12 delete"></a>
          </td>
        </tr>
      <% } %>
      </tbody>
  </table>

  <div class="pager">
    <lemoon:pagenumbers id="pagenumbers" runat="server" />
    <lemoon:pagesizer id="pagesizer" runat="server" />
  </div>

  </fieldset>   

  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save %>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:anchor id="cancel" href="~/admin/manage/daemon/default.aspx" runat="server" text="<%$ LemoonResources: Cancel %>" shortcut="esc" />
  </lemoon:buttons>    

  <script type="text/javascript">
    $(document).ready(function () {
      $('a.restore').click(function () {
        return window.confirm('<%= Mindroute.Lemoon.Properties.Resources.ConfirmResetJob %>');
      });
      $('a.delete').click(function () {
        return window.confirm('<%= Mindroute.Lemoon.Properties.Resources.ConfirmDeleteJob %>');
      });
      $('#delete').click(function () {
        if ($(this).attr('disabled')) {
          return false;
        } else {
          return window.confirm('<%= Mindroute.Lemoon.Properties.Resources.ConfirmDeleteJobs %>');
        }
      });

      $('#itemselector').click(function () {
        var checked_status = this.checked;
        $('input[name=jobitem]').each(function () {
          this.checked = checked_status;
        });
        IsItemSelected();
      });
      $('input[name=jobitem]').click(function () {
        IsItemSelected();
      });
    });
    function IsItemSelected() {
      if ($('input[name=jobitem]:checked').val() == null) {
        $('#delete').attr('disabled', 'disabled');
      }
      else {
        $('#delete').removeAttr('disabled');
      }
    }
    function setButtonState(state) {
      if (state) {
        $('.buttons').show();
      } else {
        $('.buttons').hide();
      }
    }
  </script>

</asp:content>

