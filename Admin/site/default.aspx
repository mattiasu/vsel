<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin._Site.Default" masterpagefile="~/admin/master/main.master" %>
<%@ register tagprefix="lemoon" tagname="children" src="~/admin/controls/children.ascx" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" isclipboardactive="true" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <div id="wrap">
    <div id="content" class="grid-9">
      <div class="head">
        <h1><%=Site.Title %></h1>
        <div class="permalink"><asp:literal id="permalink" runat="server" /></div>
        <lemoon:buttons id="buttons" runat="server">
          <lemoon:htmlbutton id="edit" runat="server" text="<%$ LemoonResources: Edit%>" />      
        </lemoon:buttons>
        <div class="clear"></div>
      </div>
      <div class="field">
        <label><asp:localize runat="server" text="<%$ LemoonResources: Title%>" /></label>
        <div class="text"><%= Site.Title %></div>
      </div>
      <div class="field">
        <label><asp:localize runat="server" text="<%$ LemoonResources: Language%>" /></label>
        <div class="text"><asp:literal id="lang" runat="server" /></div>
      </div>
      <div class="field">
        <label><asp:localize runat="server" text="<%$ LemoonResources: Bindings%>" /></label>
        <div class="text"><asp:placeholder id="bindings" runat="server" /></div>
      </div>
      <div class="field">
        <label><asp:localize runat="server" text="<%$ LemoonResources: Enabled%>" /></label>
        <div class="text"><asp:literal id="enabled" runat="server" /></div>
      </div>

      <lemoon:children runat="server" />
    </div>
    <div id="aside" class="grid-3">
      <lemoon:treeview id="tree" runat="server" />
    </div>  
    <div class="clear"></div>
  </div>
  
  <lemoon:contextmenu runat="server" />

</asp:content> 