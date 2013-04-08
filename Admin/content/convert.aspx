<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="convert.aspx.cs" Inherits="Mindroute.Lemoon.Admin._Content.Convert" masterpagefile="~/admin/master/main.master" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server">
    
    <lemoon:selectfield id="destination" runat="server" label="<%$ LemoonResources: ConvertTo%>" description="<%$ LemoonResources: ConvertToDescription%>" required="true" />
    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="save_Click" shortcut="Ctrl+Shift+S" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
</asp:content> 
