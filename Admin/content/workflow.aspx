<%@ page language="C#" masterpagefile="~/admin/master/main.master" autoeventwireup="true" codebehind="workflow.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Workflow" enableviewstate="false" validaterequest="false" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset runat="server">
    <lemoon:selectfield id="workflow" runat="server" label="<%$ LemoonResources: SelectWorkflow%>" description="<%$ LemoonResources: SelectWorkflow_Description%>" />
    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="save_Click" shortcut="Ctrl+Shift+S" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
</asp:content>
