<%@ page language="C#" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Site.Default" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
  <table class="list">
    <col width="200" />
    <col width="200" />
    <col width="*" />
    <col width="95" />
    <col width="95" />
    <thead>
      <tr>
        <th><asp:localize runat="server" text="<%$ LemoonResources: SystemName%>" /></th>
        <th><asp:localize runat="server" text="<%$ LemoonResources: Title%>" /></th>
        <th><asp:localize runat="server" text="<%$ LemoonResources: Bindings%>" /></th>
        <th><asp:localize runat="server" text="<%$ LemoonResources: Language%>" /></th>
        <th class="actions"><asp:localize runat="server" text="<%$ LemoonResources: Actions%>" /></th>
      </tr>
    </thead>
    <tbody>
      <asp:repeater id="repsites" runat="server" onitemdatabound="sites_ItemDataBound">
        <itemtemplate>
          <tr id="row" runat="server">
            <td><asp:literal id="systemname" runat="server" /></td>
            <td><asp:literal id="title" runat="server" /></td>
            <td><asp:literal id="bindings" runat="server" /></td>
            <td><asp:literal id="languagecode" runat="server" /></td>
            <td class="actions">
              <asp:literal id="setasdefault" runat="server" />
              <asp:literal id="addlanguage" runat="server" />
              <asp:literal id="edit" runat="server" />
              <input type="hidden" name="content" value="<%#((Mindroute.Core.Model.Site)Container.DataItem).ID%>:<%#((Mindroute.Core.Model.Site)Container.DataItem).LanguageID%>" />
            </td>
          </tr>
          <asp:repeater id="languages" runat="server" onitemdatabound="languages_ItemDataBound">
            <itemtemplate>
              <tr id="row" runat="server">
                <td></td>
                <td><asp:literal id="title" runat="server" /></td>
                <td><asp:literal id="bindings" runat="server" /></td>
                <td><%#((Mindroute.Core.Model.Site)Container.DataItem).LanguageCode%></td>
                <td class="actions"><asp:literal id="edit" runat="server" /></td>
              </tr>
            </itemtemplate>
          </asp:repeater>
        </itemtemplate>
      </asp:repeater>
    </tbody> 
  </table>
  
  <p id="sortinfo" style="display: none;">
  
  <asp:localize runat="server" text="<%$ LemoonResources: ChangesMadeToTable%>" /></p>

  <script type="text/javascript">
    function SetDefaultSite(siteID) {
      if (!window.confirm('<%=Mindroute.Lemoon.Properties.Resources.ConfirmSetAsDefaultSite %>')) {
        return;
      }
      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: Lemoon.RootUrl() + "admin/api/content/setdefaultsite?siteid=" + siteID,
        dataType: "json",
        cache: false,
        error: function(XMLHttpRequest, textStatus, errorThrown) {
          alert(textStatus);
        },
        success: function(data, textStatus) {
          if (data.Status != "error") {
            location.reload(true);
          } else {
            alert(data.Message);
          }
        }
      });
    }
  </script>

</asp:content>
