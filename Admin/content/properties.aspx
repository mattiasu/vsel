<%@ page language="C#" autoeventwireup="true" codebehind="properties.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Properties" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ register src="~/admin/controls/metadata.ascx" tagname="metadata" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/alias.ascx" tagname="alias" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/seo.ascx" tagname="seo" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/feed.ascx" tagname="feed" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/properties.ascx" tagname="properties" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/visibility.ascx" tagname="visibility" tagprefix="lemoon" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">

  <lemoon:fieldset id="general" runat="server">
    <lemoon:properties id="properties" runat="server" />    
    <lemoon:radiofield id="applyto" runat="server" label="<%$ LemoonResources: ApplyTo%>" visible="false" />
  </lemoon:fieldset> 

  <lemoon:fieldset id="visibilitytab" runat="server" enabled="false">
    <lemoon:visibility id="visibility" runat="server" />
  </lemoon:fieldset> 
  
  <lemoon:fieldset id="metadatatab" runat="server" enabled="false">
    <lemoon:metadata id="metadata" runat="server" />
  </lemoon:fieldset>

  <lemoon:fieldset id="aliastab" runat="server" enabled="false">
    <lemoon:alias id="alias" runat="server" />
  </lemoon:fieldset>

  <lemoon:fieldset id="seotab" runat="server" enabled="false">
    <lemoon:seo id="seo" runat="server" />
  </lemoon:fieldset>
  
  <lemoon:fieldset id="feedtab" runat="server" enabled="false">
      <lemoon:feed id="feed" runat="server" />
  </lemoon:fieldset>

  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" href="~/admin/content/?id={id}" shortcut="Esc" />
  </lemoon:buttons>

</asp:content>
