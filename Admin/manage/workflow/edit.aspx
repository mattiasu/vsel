<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Workflow._Edit" masterpagefile="~/admin/master/main.master" enableviewstate="false" enableeventvalidation="false"  %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">

  <lemoon:fieldset id="edit" runat="server">
    <lemoon:textfield id="name" runat="server" required="true" label="<%$LemoonResources:Name%>" description="<%$LemoonResources:NameOfWorkflowDescription%>" />
    <lemoon:rolesfield id="roles" runat="server" label="<%$LemoonResources:Reviewers%>" description="<%$LemoonResources:ReviewersDescription%>" />
  </lemoon:fieldset>
  
  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$LemoonResources:Save%>" onclick="save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
  </lemoon:buttons>
</asp:content>
