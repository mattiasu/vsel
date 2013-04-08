<%@ page language="C#" autoeventwireup="false" codebehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._Content.Edit" masterpagefile="~/admin/master/main.master" %>
<asp:content contentplaceholderid="head" runat="server">
  <script type="text/javascript" src="<%=ResolveUrl("~/admin/js/shCore.js") %>"></script>
  <script type="text/javascript" src="<%=ResolveUrl("~/admin/js/shBrushCSharp.js") %>"></script>
  <link type="text/css" rel="stylesheet" href="<%=ThemeService.GetUrl("shCore.css") %>" />
  <link type="text/css" rel="stylesheet" href="<%=ThemeService.GetUrl("shThemeDefault.css") %>"/>
  <script type="text/javascript">
    SyntaxHighlighter.all();
  </script>
</asp:content>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
  <asp:validationsummary runat="server" />
  
  <lemoon:fieldset id="definition" runat="server">
    <table>
      <col width="95" />
      <col width="200" />
      <col width="200" />
      <col width="*" />
      <thead>
        <tr>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Type%>" /></th>
          <th><asp:localize runat="server" text="<%$ LemoonResources: PropertyName%>" /></th>
          <th><asp:localize runat="server" text="<%$ LemoonResources: DisplayName%>" /></th>
          <th><asp:localize runat="server" text="<%$ LemoonResources: Description%>" /></th>
        </tr>
      </thead>
      <tbody>
        <asp:repeater id="def" runat="server">
          <itemtemplate>
            <tr>
              <td><%#Mindroute.Lemoon.Helpers.DesignHelper.GetPropertyType(((Mindroute.Core.Model.PersistedField)Container.DataItem).PropertyType)%></td>
              <td><%#((Mindroute.Core.Model.PersistedField)Container.DataItem).Name%></td>
              <td><%#((Mindroute.Core.Model.PersistedField)Container.DataItem).DisplayName%></td>
              <td><%#((Mindroute.Core.Model.PersistedField)Container.DataItem).Description%></td>
            </tr>
          </itemtemplate>
        </asp:repeater>
      </tbody>
    </table>
  </lemoon:fieldset> 
  
  <lemoon:fieldset id="properties" runat="server">
    <lemoon:labelfield id="name" runat="server" label="<%$ LemoonResources: Name%>" />
    <lemoon:labelfield id="description" runat="server" label="<%$ LemoonResources: Description%>" />
    <lemoon:selectfield id="template" runat="server" label="<%$ LemoonResources: Template%>" />

    <lemoon:radiobuttonsfield id="category" runat="server" label="<%$ LemoonResources: AllowedChildren%>" repeatdirection="Horizontal" />
    <div id="allowedChildrenContainer" runat="server" class="field allowedchildren">
      <label>&nbsp;</label>
      <div class="group">
        <span id="allowedChildren" runat="server" />
      </div>
      <div class="info"><asp:localize runat="server" text="<%$ LemoonResources: AllowedChildrenDescription%>" /></div>
      <script type="text/javascript">
         $("document").ready(function () {
           changeMode();
           var field = $(".tab .field.allowedchildren").prev(".field");
           $(field).css("border-bottom", "0");
           $(field).find("input[type='radio']").change(function () {
             changeMode();
           });
         });

         function changeMode() {
           var field = $(".tab .field.allowedchildren");

           if ($("input[name='<%=category.UniqueID%>$f']:checked").val() == 2) {
             $(field).find("input[type='checkbox']").each(function () {
               $(this).removeAttr("disabled");
             });
           } else {
             $(field).find("input[type='checkbox']").each(function (index) {
               $(this).attr("disabled", "disabled");
             });
           }
         } 
    </script>
    </div>

    <div id="displayContainer" runat="server" class="field">
      <label>Display</label>
      <div class="group">
        <span class="checkbox">
          <asp:checkbox id="displayinmenu" runat="server" text="<%$ LemoonResources: DisplayInMenu%>" /><br />
          <asp:checkbox id="displayinsitemap" runat="server" text="<%$ LemoonResources: DisplayInSitemap%>" /><br />
          <asp:checkbox id="displayintree" runat="server" text="<%$ LemoonResources: DisplayInTree%>" />
        </span>
      </div>
      <div class="info"><asp:localize runat="server" text="<%$ LemoonResources: DisplayInMenuDescription%>" /></div>
    </div>

    <lemoon:radiofield id="commenting" runat="server" label="<%$ LemoonResources: Commenting%>" description="<%$ LemoonResources: AllowCommentingDescription%>" />
    <lemoon:booleanfield id="tagging" runat="server" label="<%$ LemoonResources: IsTaggingEnabled%>" description="<%$ LemoonResources: IsTaggingEnabledDescription%>" />
    <lemoon:booleanfield id="routing" runat="server" label="<%$ LemoonResources: IsRoutable%>" description="<%$ LemoonResources: IsRoutableDescription%>" />
    <lemoon:booleanfield id="indexed" runat="server" label="<%$ LemoonResources: IncludeInSearch%>" description="<%$ LemoonResources: IncludeInSearchCTDescription%>" />
    <lemoon:booleanfield id="enabled" runat="server" label="<%$ LemoonResources: Enabled%>" description="<%$ LemoonResources: ContentTypeEnabledDescription%>" />
    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="Save_Click" shortcut="Ctrl+Shift+S" />
      <lemoon:anchor href="~/admin/manage/content/default.aspx" id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
  
  <lemoon:fieldset id="codeField" runat="server">
    <pre class="brush:c-sharp;"><asp:literal id="code" runat="server" /></pre>
  </lemoon:fieldset>
  


</asp:content>
