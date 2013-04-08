<%@ page language="C#" autoeventwireup="false" codebehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Site.Edit" masterpagefile="~/admin/master/main.master" %>
<%@ register src="~/admin/controls/customsettings.ascx" tagname="customsettings" tagprefix="lemoon" %>
<%@ register src="~/admin/controls/metadata.ascx" tagname="metadata" tagprefix="lemoon" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">

  <lemoon:fieldset id="edit" runat="server" hidden="false">
    <lemoon:textfield id="sitename" runat="server" label="<%$ LemoonResources: SystemName%>" description="<%$ LemoonResources: SystemNameDescription%>" required="true" enableviewstate="false" />
    <lemoon:textfield id="name" runat="server" label="<%$ LemoonResources: Title%>" description="<%$ LemoonResources: SiteTitleDescription%>" required="true" enableviewstate="false" />
    <asp:placeholder id="languageprop" runat="server">
      <lemoon:selectfield id="languages" runat="server" label="<%$ LemoonResources: Language%>" required="true" enableviewstate="false" />
      <lemoon:contentfield id="rootpage" runat="server" pickers="Pages" label="<%$ LemoonResources: DefaultRootPage%>" description="<%$ LemoonResources: DefaultRootPageHelpText%>" enableviewstate="false" />
      <lemoon:folderfield id="defaultUploadFolder" allowsiteselection="true" runat="server" label="<%$ LemoonResources: DefaultUploadFolder%>" description="<%$ LemoonResources: DefaultUploadFolderDescription%>" />
      <lemoon:selectfield id="defaulttemplate" runat="server" label="<%$ LemoonResources: DefaultTemplate%>" description="<%$ LemoonResources: DefaultTemplateDescription%>" />
      <lemoon:booleanfield id="enabled" runat="server" label="<%$ LemoonResources: Enabled%>" enableviewstate="false" value="true" />
    </asp:placeholder>
    <div class="field" id="fallbackMode" runat="server" visible="false">
      <label><asp:localize runat="server" text="<%$ LemoonResources: FallbackMode%>" /></label>
      <div class="group">
        <asp:checkbox id="fallbackcontent" runat="server" text="<%$ LemoonResources: FallbackContent%>" cssclass="checkbox" checked="true" /><br />
        <asp:checkbox id="fallbackbinary" runat="server" text="<%$ LemoonResources: FallbackBinary%>" cssclass="checkbox" checked="true" /><br />
        <asp:checkbox id="fallbackcontainer" runat="server" text="<%$ LemoonResources: FallbackContainer%>" cssclass="checkbox" checked="true" /><br />
      </div>
      <div class="info"><asp:localize runat="server" text="<%$ LemoonResources: FallbackModeDescription%>" /></div>
    </div>
    <div id="sort" runat="server" class="field" visible="false">
      <label><asp:localize runat="server" text="<%$ LemoonResources: SortOrder%>" /></label>
      <div class="group">
        <asp:repeater id="sitesort" runat="server">
          <headertemplate>
            <ol id="sortable">
          </headertemplate>
          <itemtemplate>
            <li>
              <span class="icon-12 sort"></span><%#((Mindroute.Core.Model.Site)Container.DataItem).SystemName.Ellipsis(20)%> [<%#((Mindroute.Core.Model.Site)Container.DataItem).LanguageCode%>]
              <input type="hidden" name="site" value="<%#((Mindroute.Core.Model.Site)Container.DataItem).LanguageID%>" />
            </li>
          </itemtemplate>
          <footertemplate>
            </ol>
          </footertemplate>
        </asp:repeater>
      </div>
      <div class="info"><asp:localize runat="server" text="<%$ LemoonResources: SortManualHelpText%>" /></div>
      <div class="clear"></div>
      <p id="sortinfo" style="display: none;">
        <asp:localize runat="server" text="<%$ LemoonResources: ChangesMadeToTable%>" />
      </p>
    </div>
  </lemoon:fieldset> 
  
  <lemoon:fieldset id="seo" runat="server" enabled="false">
    <lemoon:textareafield id="metakeywords" runat="server" label="<%$ LemoonResources: Seo_MetaKeywords_Name%>" height="50px" width="400px" description="<%$ LemoonResources: Seo_MetaKeywords_Description%>" />
    <lemoon:textareafield id="metadescription" runat="server" label="<%$ LemoonResources: Seo_MetaDescription_Name%>" height="100px" width="400px" description="<%$ LemoonResources: Seo_MetaDescription_Description%>" />
    <lemoon:textfield id="analyticsid" runat="server" label="<%$ LemoonResources: Seo_AnalyticsID_Name%>" description="<%$ LemoonResources: Seo_AnalyticsID_Description%>" />
    <lemoon:textfield id="verificationcode" runat="server" label="<%$ LemoonResources: Seo_SiteVerification_Name%>" description="<%$ LemoonResources: Seo_SiteVerification_Description%>" />
  </lemoon:fieldset>

  <lemoon:fieldset id="bindingstab" runat="server" enabled="false">
    <div class="field" id="f" runat="server">
      <label><asp:localize runat="server" text="<%$ LemoonResources: Bindings%>" /></label>
      <table id="bindings">
        <col width="300" />
        <col width="200" />
        <col width="*" />
        <thead>
          <tr>
            <th><asp:localize runat="server" text="<%$ LemoonResources: HostName%>" /></th>
            <th><asp:localize runat="server" text="<%$ LemoonResources: VirtualDir %>" /></th>
            <th class="actions"></th>
          </tr>
        </thead>
        <tfoot>
          <tr class="add" enableviewstate="false">
            <td colspan="3">
              <a href="javascript:void(0);" onclick="LemoonBinding.Add();return false;"><span class="icon-12 add"></span><asp:localize runat="server" text="<%$ LemoonResources: AddBinding %>" /></a>
            </td>
          </tr>
        </tfoot> 
        <tbody>     
        <asp:repeater id="bindingsRep" runat="server">
          <itemtemplate>
            <tr>
              <td>
                <input type="text" name="binding_host" value="<%#((Mindroute.Core.Model.Binding)Container.DataItem).HostName%>" />
              </td>
              <td>
                <input type="text" name="binding_vdir" value="<%#((Mindroute.Core.Model.Binding)Container.DataItem).VirtualDir%>" />
              </td>
              <td class="actions"><a href="javascript:void(0);"><span class="icon-12 delete" onclick="LemoonBinding.Remove(this);"></span></a></td>
            </tr>
          </itemtemplate>          
        </asp:repeater>
        </tbody>
      </table>
      <asp:literal id="e" runat="server" />
    </div>
  </lemoon:fieldset> 
  
  <lemoon:fieldset id="customTab" runat="server" enabled="false">
    <lemoon:customsettings id="customSettings" runat="server" />
  </lemoon:fieldset> 

  <lemoon:fieldset id="metadatatab" runat="server" enabled="false">
    <lemoon:metadata id="metadata" runat="server" />
  </lemoon:fieldset>

  <lemoon:buttons runat="server">
    <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
    <lemoon:linkbutton id="delete" runat="server" text="<%$ LemoonResources: Delete%>" onclick="delete_Click" />
    <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" href="~/admin/manage/site/" />
  </lemoon:buttons>

  <script type="text/javascript">
    $(document).ready(function() {
      $("#sortable").sortable({
        placeholder: 'sortplaceholder',
        handle: 'span',
        axis: 'y',
        forcePlaceholderSize: true,
        forceHelperSize: true,
        update: function(event, ui) {
          $("#sortinfo").show();
        }
      });
    });
  </script>
  
</asp:content>
