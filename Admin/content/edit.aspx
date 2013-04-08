<%@ page language="C#" autoeventwireup="true" codebehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Edit" masterpagefile="~/admin/master/main.master" validaterequest="false" enableviewstate="false" enableeventvalidation="false" %>
<%@ register src="~/admin/controls/metadata.ascx" tagname="metadata" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/alias.ascx" tagname="alias" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/seo.ascx" tagname="seo" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/feed.ascx" tagname="feed" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/properties.ascx" tagname="properties" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/visibility.ascx" tagname="visibility" tagprefix="lemoon" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="head" runat="server">
  <script type="text/javascript" src="../js/lemoon.form.js"></script>
  <script type="text/javascript" src="../js/lemoon.alias.js"></script>
</asp:content>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">

  <lemoon:fieldset id="edit" runat="server">
    <lemoon:textfield id="title" runat="server" label="" required="true" />
    <div id="editExtra">
      <lemoon:textfield id="menutitle" runat="server" label="<%$ LemoonResources: MenuTitle%>" description="<%$ LemoonResources: MenuTitleDescription%>" />
      <lemoon:textfield id="teaser" runat="server" label="<%$ LemoonResources: Teaser%>" description="<%$ LemoonResources: TeaserDescription%>" width="400px" height="100px" textmode="MultiLine" />
    </div>
    <lemoon:tagfield id="tags" runat="server" label="<%$ LemoonResources: Tags%>" description="<%$ LemoonResources: TagsDescription%>" />
    <asp:placeholder id="plh" runat="server" />
  </lemoon:fieldset>
  
  <lemoon:fieldset id="propertiestab" runat="server" enabled="false">
    <lemoon:properties id="properties" runat="server" />
  </lemoon:fieldset>
  
  <lemoon:fieldset id="visibilitytab" runat="server" enabled="false">
    <lemoon:visibility id="visibility" runat="server" />
  </lemoon:fieldset> 
  
  <lemoon:fieldset id="metadataTab" runat="server" enabled="false">
    <lemoon:metadata id="metadata" runat="server" />
  </lemoon:fieldset>
  
  <lemoon:fieldset id="aliases" runat="server" enabled="false">
    <lemoon:alias id="alias" runat="server" />
  </lemoon:fieldset>
  
  <lemoon:fieldset id="seotab" runat="server" enabled="false">
    <lemoon:seo id="seo" runat="server" />
  </lemoon:fieldset>
  
  <lemoon:fieldset id="feedtab" runat="server" enabled="false">
      <lemoon:feed id="feed" runat="server" />
  </lemoon:fieldset>

  <lemoon:buttons runat="server">
    <lemoon:button id="publish" runat="server" text="<%$ LemoonResources: Publish%>" onclick="publish_Click" shortcut="Ctrl+Shift+S" onclientclick="LemoonForm.setCancelConfirm(true);" />
    <lemoon:linkbutton id="savedraft" runat="server" text="<%$ LemoonResources: SaveDraft%>" onclick="savedraft_Click" shortcut="Ctrl+Shift+A" onclientclick="LemoonForm.setIsDirty(false);" />
    <lemoon:linkbutton id="preview" runat="server" text="<%$ LemoonResources: Preview%>" onclick="preview_Click" onclientclick="LemoonForm.setIsDirty(false);" visible="false" />
    <lemoon:linkbutton id="discard" runat="server" text="<%$ LemoonResources: UndoChanges%>" onclick="discard_Click" visible="false" />
    <lemoon:linkbutton id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" onclick="cancel_Click" />
  </lemoon:buttons>

  <input id="id" type="hidden" value="<%=_currentContentID%>" />
  <input id="lid" type="hidden" value="<%=_languageID%>" />
  <input id="ctid" type="hidden" value="<%=_contentTypeID%>" />
  <input id="pid" type="hidden" value="<%=_currentID%>" />
  <input id="transientID" name="transientID" type="hidden" value="" />

  <script type="text/javascript">
    $('#more').live('click', function() {
      LemoonForm.setNeedConfirm(false);
      $('#editExtra').toggle();
      return false;  
    });
  </script>
</asp:content>
