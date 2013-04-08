<%@ page language="C#" autoeventwireup="true" codebehind="folder.aspx.cs" inherits="Mindroute.Lemoon.Admin._File._Folder" masterpagefile="~/admin/master/main.master" %>
<%@ register src="~/admin/controls/metadata.ascx" tagname="metadata" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/properties.ascx" tagname="properties" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/visibility.ascx" tagname="visibility" tagprefix="lemoon" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:filemenu runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="edit" runat="server">
    <lemoon:textfield id="title" runat="server" label="<%$ LemoonResources: Title%>" width="300px" required="true" />
    <lemoon:textfield id="description" runat="server" label="<%$ LemoonResources: Description%>" width="300px" />
  </lemoon:fieldset>

  <lemoon:fieldset id="general" runat="server" enabled="false">
    <lemoon:properties id="properties" runat="server" />    
    <lemoon:radiofield id="applyto" runat="server" label="<%$ LemoonResources: ApplyTo%>" visible="false" />
  </lemoon:fieldset> 

  <lemoon:fieldset id="visibilitytab" runat="server" enabled="false">
    <lemoon:visibility id="visibility" runat="server" />
  </lemoon:fieldset> 
  
  <lemoon:fieldset id="metadatatab" runat="server" enabled="false">
    <lemoon:metadata id="metadata" runat="server" />
  </lemoon:fieldset>

  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/file/?id={id}" shortcut="Esc" />
  </lemoon:buttons>

</asp:content>
