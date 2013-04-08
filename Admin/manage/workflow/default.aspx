<%@ page language="C#" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Workflow.Default" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>
<asp:content runat="server" contentplaceholderid="content">
  <table>
    <col width="30" />
    <col width="340" />
    <col width="*" />
    <col width="95" />
    <thead>
      <tr>
        <th class="check">
          <input type="checkbox" id="itemselector" />
        </th>
        <th>
          <asp:localize runat="server" text="<%$ LemoonResources: Name%>" />
        </th>
        <th>
          <asp:localize runat="server" text="<%$ LemoonResources: Reviewers%>" />
        </th>
        <th class="actions">
          <asp:localize runat="server" text="<%$ LemoonResources: Actions%>" />
        </th>
      </tr>
    </thead>
    <tfoot>
      <tr class="add" enableviewstate="false">
        <td>
        </td>
        <td colspan="4">
          <lemoon:actionanchor runat="server" href="~/admin/manage/workflow/edit.aspx" text="<%$ LemoonResources: AddWorkflow%>" shortcut="Ctrl+Shift+A" />
        </td>
      </tr>
      <tr>
        <td colspan="4">
          <lemoon:bulkbutton id="delete" runat="server" onclick="delete_Click" text="<%$ LemoonResources: DeleteSelected%>" cssclass="delete" />,
          <div class="clear">
          </div>
        </td>
      </tr>
    </tfoot>
    <tbody>
      <tr id="dnoitems" runat="server" visible="false">
        <td colspan="4">
          <asp:localize runat="server" text="<%$ LemoonResources: NoResults%>" />
        </td>
      </tr>
      <asp:repeater id="workflows" runat="server" onitemdatabound="workflows_ItemDataBound">
        <itemtemplate>
          <tr>
            <td class="check">
              <input type="checkbox" name="wfitem" value="<%#((Mindroute.Lemoon.Modules.WorkflowModule.Workflow)Container.DataItem).ID%>" />
            </td>
            <td>
              <a id="edit" runat="server">
                <%#((Mindroute.Lemoon.Modules.WorkflowModule.Workflow)Container.DataItem).Name%>  
              </a>     
            </td>
            <td>
              <asp:literal id="groups" runat="server" />
            </td>
            <td class="actions">
              <lemoon:bulkbutton id="delete" runat="server" oncommand="delete_Command" tooltip="<%$ LemoonResources: DeleteSelected%>" commandargument="<%#((Mindroute.Lemoon.Modules.WorkflowModule.Workflow)Container.DataItem).ID%>" cssclass="delete" />
            </td>
          </tr>
        </itemtemplate>
      </asp:repeater>
    </tbody>
  </table>

  <script type="text/javascript">
    $(document).ready(function() {
      $("#itemselector").click(function() {
        var checked_status = this.checked;
        $("input[name=wfitem]").each(function() {
          this.checked = checked_status;
        });
        IsItemSelected();
      });
      $('input[name=wfitem]').click(function() {
        IsItemSelected();
      });
    });
    function IsItemSelected() {
      if ($('input[name=wfitem]:checked').val() == null) {
        $('#<%=delete.ClientID %>').attr('disabled', '1');
      }
      else {
        $('#<%=delete.ClientID %>').removeAttr('disabled');
      }
    }
  </script>

</asp:content>
