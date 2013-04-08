<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="mindroute.lemoon.modules.formmodule.formholder.ascx.cs" Inherits="Mindroute.Lemoon.Admin._Content._View.FormHolderView" %>

<lemoon:labelfield id="body" runat="server" label="<%$ LemoonResources: FormHolder_Body_Name%>" />
<lemoon:labelfield id="selectedForm" runat="server" label="<%$ LemoonResources: SelectedForm%>" />
<lemoon:labelfield id="sender" runat="server" label="<%$ LemoonResources: EmailSender%>" />
<lemoon:labelfield id="recipient" runat="server" label="<%$ LemoonResources: EmailRecipient%>" />
<lemoon:labelfield id="subject" runat="server" label="<%$ LemoonResources: EmailSubject%>" />
<lemoon:labelfield id="redirectTo" runat="server" label="<%$ LemoonResources: RedirectTo%>" />
<lemoon:labelfield id="validationGroup" runat="server" label="<%$ LemoonResources: ValidationGroup%>" />
<br />

<div class="filter">
  <div class="group">
    <a id="currentLanguage" runat="server"><asp:localize runat="server" text="<%$LemoonResources: CurrentLanguage%>" /></a>
    <a id="allLanguages" runat="server"><asp:localize runat="server" text="<%$LemoonResources: AllLanguages%>" /></a>
  </div>
  <asp:textbox id="phrase" runat="server" />
</div>  
<table>
  <thead>
    <tr id="thead" runat="server" />
  </thead>
  <tfoot>
      <tr enableviewstate="false">
        <td runat="server" id="tfoot">
          <lemoon:bulkbutton id="export" runat="server" onclick="export_Click" cssclass="add" />
          <lemoon:bulkbutton id="removeAll" runat="server" onclick="removeAll_Click" cssclass="recycle-bin" />
        </td>
    </tr>              
  </tfoot>
  <tbody>
    <asp:repeater id="items" runat="server" onitemdatabound="items_ItemDataBound">
      <itemtemplate>
        <tr id="tableRow" runat="server" />
      </itemtemplate>
    </asp:repeater>
  </tbody>
</table>

<div class="pager">
  <lemoon:pagenumbers id="pagenumbers" runat="server" />
  <lemoon:pagesizer id="pagesizer" runat="server" />
</div>

<script type="text/javascript">
  $(document).ready(function() {
    $("tbody tr:odd").addClass("alt");
    $("#<%=phrase.ClientID %>").watermark("<%=Mindroute.Lemoon.Properties.Resources.Filter %>");
  });
</script>
