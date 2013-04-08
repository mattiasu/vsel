<%@ page language="C#" autoeventwireup="true" codebehind="translate.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Translate" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server" description="<%$ LemoonResources: TranslateDescription%>">
    <table id="translation">
      <col width="*" />
      <col width="200" />
      <col width="95" />
      <thead>
        <tr>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Title%>" /></th>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Language%>" /></th>
          <th class="actions"><asp:localize runat="server" text="<%$ LemoonResources: Actions%>" /></th>
        </tr>
      </thead>
      <tbody>
        <asp:repeater id="languages" runat="server" onitemdatabound="Languages_ItemDataBound">
          <itemtemplate>
            <tr>
              <td><a id="title" runat="server" /></td>
              <td id="lang" runat="server"></td>
              <td class="actions"><a id="operation" runat="server" /></td>
            </tr>
          </itemtemplate>
        </asp:repeater>
      </tbody> 
    </table>
    <lemoon:buttons runat="server">
      <lemoon:anchor runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/content/default.aspx?id={id}" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
</asp:content>
