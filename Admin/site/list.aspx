<%@ page language="C#" autoeventwireup="true" codebehind="list.aspx.cs" inherits="Mindroute.Lemoon.Admin._Site.List" masterpagefile="~/admin/master/main.master" %>
<%@ import namespace="Mindroute.Core.Model" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" />
</asp:content>
<asp:content contentplaceholderid="content" runat="server">
  <div class="filter">
    <asp:textbox id="f" runat="server" />
  </div>
  <table>
    <col width="200" />
    <col width="*" />
    <col width="95" />
    <col width="95" />
    <thead>
      <tr>
        <th><asp:localize runat="server" text="<%$LemoonResources: SystemName %>" /></th>
        <th><asp:localize runat="server" text="<%$LemoonResources: Title%>" /></th>
        <th><asp:localize runat="server" text="<%$LemoonResources: Language %>" /></th>
        <th class="actions"><asp:localize runat="server" text="<%$LemoonResources: Actions%>" /></th>
      </tr>
    </thead>
    <tbody>
      <tr id="nohits" runat="server" visible="false">
        <td colspan="4"><asp:localize runat="server" text="<%$LemoonResources:NoResults%>" /></td>
      </tr>
      <asp:repeater id="sites" runat="server" onitemdatabound="Sites_ItemDataBound">
        <itemtemplate>
          <tr>
            <td><a id="link" runat="server" /></td>
            <td><%#((Site)Container.DataItem).Title%></td>
            <td><%#((Site)Container.DataItem).LanguageCode%></td>
            <td class="actions"><a id="edit" runat="server" title="<%$LemoonResources: SelectSite%>"><span class="icon-12 allow"></span></a></td>
          </tr>          
        </itemtemplate>
      </asp:repeater>
    </tbody>
  </table>
  <script type="text/javascript">
    $("#<%=f.ClientID%>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Filter%>");
  </script>
</asp:content>
