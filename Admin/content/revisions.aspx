<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="revisions.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Revisions" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:panel id="p" runat="server" description="<%$ LemoonResources: RevisionsDescription%>">
    <table style="table-layout:fixed;">
      <col width="120" />
      <col width="140" />
      <col width="*" />
      <col width="200" />
      <col width="70" />
      <thead>
        <tr>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Revision%>" /></th>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Created%>" /></th>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Title%>" /></th>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Author%>" /></th>
          <th class="actions""><asp:localize runat="server" text="<%$ LemoonResources: Actions%>" /></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><a id="revision" runat="server" /></td>
          <td id="created" runat="server"></td>
          <td id="title" runat="server"></td>
          <td id="author" runat="server"></td>
          <td class="actions"></td>
        </tr>
        <asp:repeater id="revisions" runat="server" onitemdatabound="Revisions_ItemDataBound">
          <itemtemplate>
            <tr>
              <td><a id="revision" runat="server" /></td>
              <td id="created" runat="server"></td>
              <td id="title" runat="server" class="ellipsis"></td>
              <td id="author" runat="server"></td>
              <td class="actions">
                <lemoon:bulkbutton id="revert" class="revert" runat="server" title="<%$ LemoonResources: Revert%>" oncommand="Revert_Command" cssclass="restore" />
                <lemoon:bulkbutton id="delete" class="delete" runat="server" title="<%$ LemoonResources: Delete%>" oncommand="Delete_Command" cssclass="delete" />
              </td>
            </tr>
          </itemtemplate>
        </asp:repeater>
        <tr id="noitems" runat="server" visible="false">
          <td colspan="5"><asp:localize runat="server" text="<%$ LemoonResources: NoRevisons%>" /></td>
        </tr>
      </tbody>
    </table>
    
    <lemoon:buttons runat="server">
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/content/?id={id}" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:panel>
  
  <lemoon:panel id="revisionPanel" runat="server" description="<%$ LemoonResources: RevisionsDescription%>" visible="false">
    <asp:placeholder id="f" runat="server" />
    
    <lemoon:buttons runat="server">
      <lemoon:anchor id="back" runat="server" text="<%$ LemoonResources: Back%>" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:panel> 

  <script type="text/javascript">
    $(document).ready(function() {
      $("a.revert").click(function() {
        return window.confirm('<asp:localize runat="server" text="<%$ LemoonResources: ConfirmRevertRevision%>" />');
      });
    });
    $(document).ready(function() {
      $("a.delete").click(function() {
        return window.confirm('<asp:localize runat="server" text="<%$ LemoonResources: ConfirmDeleteRevision%>" />');
      });
    });
  </script>
</asp:content>
