<%@ page language="C#" autoeventwireup="false" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Search.Default" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>

<asp:content runat="server" contentplaceholderid="content">
  <p class="description">
    <asp:localize runat="server" text="<%$ LemoonResources: SearchResultDescription%>" />
  </p>
  <div class="filter">
    <div class="group">
      <a id="a" runat="server"><asp:localize runat="server" text="<%$LemoonResources: All%>" /></a> 
      <a id="p" runat="server"><asp:localize runat="server" text="<%$LemoonResources: Site%>" /></a> 
      <a id="f" runat="server"><asp:localize runat="server" text="<%$LemoonResources: Files%>" /></a>           
    </div>
    <div class="group">
      <a id="g" runat="server"><asp:localize runat="server" text="<%$LemoonResources: AllSites%>" /></a>
      <a id="l" runat="server"><asp:localize runat="server" text="<%$LemoonResources: CurrentSite%>" /></a>
    </div>
    <asp:textbox id="s" runat="server" />
  </div>
  <%-- Pages --%>
  <table>
    <col width="*" />
    <col width="200" />
    <col width="200" />
    <col width="95" />
    <asp:repeater id="pages" runat="server" onitemdatabound="Page_ItemDataBound">
      <headertemplate>
        <tr class="thead">
          <th><asp:localize id="more" runat="server" /></th>
          <th><asp:localize runat="server" text="<%$LemoonResources: Parent%>" /></th>
          <th><asp:localize runat="server" text="<%$LemoonResources: CreatedBy%>" /></th>
          <th><asp:localize runat="server" text="<%$LemoonResources: Created%>" /></th>
        </tr>
        <tr id="nohits" runat="server" visible="false">
          <td colspan="4">
            <asp:localize runat="server" text="<%$ LemoonResources: NoResults%>" />
          </td>
        </tr>
      </headertemplate>
      <itemtemplate>
        <tr id="row" runat="server" />
      </itemtemplate>
      <footertemplate>
        <tr id="m" runat="server" visible="false">
          <td colspan="4">
            <a id="l" runat="server">
              <asp:localize runat="server" text="<%$LemoonResources: More%>" /></a>
          </td>
        </tr>
      </footertemplate>
    </asp:repeater>
    <%-- Files --%>
    <asp:repeater id="files" runat="server" onitemdatabound="File_ItemDataBound">
      <headertemplate>
        <tr class="thead">
          <th><asp:localize id="more" runat="server" /></th>
          <th><asp:localize runat="server" text="<%$LemoonResources: Parent%>" /></th>
          <th><asp:localize runat="server" text="<%$LemoonResources: CreatedBy%>" /></th>
          <th><asp:localize runat="server" text="<%$LemoonResources: Created%>" /></th>
        </tr>
        <tr id="nohits" runat="server" visible="false">
          <td colspan="4">
            <asp:localize runat="server" text="<%$ LemoonResources: NoResults%>" />
          </td>
        </tr>
      </headertemplate>
      <itemtemplate>
        <tr id="row" runat="server" />
      </itemtemplate>
      <footertemplate>
        <tr id="m" runat="server" visible="false">
          <td colspan="4">
            <a id="l" runat="server">
              <asp:localize runat="server" text="<%$LemoonResources: More%>" /></a>
          </td>
        </tr>
      </footertemplate>
    </asp:repeater>
  </table>

  <div class="pager">
    <lemoon:pagenumbers id="pagenumbers" runat="server" />
    <lemoon:pagesizer id="pagesizer" runat="server" />
  </div>

  <script type="text/javascript">
    $("#<%=s.ClientID%>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Search%>...");
  </script>

</asp:content>
