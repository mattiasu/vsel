<%@ page language="C#" autoeventwireup="false" codebehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Function.Edit" masterpagefile="~/admin/master/main.master" %>
<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset runat="server" id="properties">
    <lemoon:labelfield id="name" runat="server" label="<%$ LemoonResources: Name%>" />
    <lemoon:labelfield id="description" runat="server" label="<%$ LemoonResources: Description%>" /> 
    <asp:placeholder id="labelControls" runat="server" />
    <asp:placeholder id="editControls" runat="server" />
  </lemoon:fieldset>

  <lemoon:buttons runat="server">
    <lemoon:button id="execute" runat="server" text="<%$ LemoonResources: Execute %>" onclick="Execute_Click" />
    <lemoon:anchor id="cancel" href="~/admin/manage/function/default.aspx" runat="server" text="<%$ LemoonResources: Cancel %>" shortcut="esc" />
  </lemoon:buttons>    
  
</asp:content>
