<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="design.aspx.cs" Inherits="Mindroute.Lemoon.Admin.Manage._Content.Design" masterpagefile="~/admin/master/main.master" enableviewstate="false" validaterequest="false" %>

<asp:content contentplaceholderid="head" runat="server">
  <script type="text/javascript" src="<%= ResolveUrl("~/admin/js/jquery.form.js") %>"></script>
  <script type="text/javascript" src="<%= ResolveUrl("~/admin/js/lemoon.designer.js") %>"></script>
  <script type="text/javascript" src="<%= ResolveUrl("~/admin/js/jquery.json-2.2.min.js") %>"></script>
  <link type="text/css" href="<%= ThemeService.GetUrl("designer.css") %>" rel="stylesheet" media="screen" />
</asp:content>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
  <asp:validationsummary runat="server" />
    <div id="wrap" style="overflow:auto;">      
      <div id="content">        
        <ul id="stage" class="<%=_stageClass %>">
        <asp:repeater id="fields" runat="server" onitemdatabound="fields_ItemDataBound">
          <itemtemplate><asp:literal id="l" runat="server" /></itemtemplate>
        </asp:repeater>
        </ul>        
      </div>
      <div class="scrollIdentifier"></div>
      <div id="aside">
        <div class="tabs">
          <ul>
            <li class="selected"><a id="formsettingstab" href="javascript:void(0);" onclick="LemoonDesigner.ShowTab('formsettings', this);"><asp:localize runat="server" text="<%$ LemoonResources: General%>" /></a></li>
            <li><a id="fieldtab" href="javascript:void(0);" onclick="LemoonDesigner.ShowTab('formfields', this);"><asp:localize runat="server" text="<%$ LemoonResources: AddField%>" /></a></li>
            <li><a id="propertiestab" href="javascript:void(0);" onclick="LemoonDesigner.ShowTab('properties', this);" disabled="disabled"><asp:localize runat="server" text="<%$ LemoonResources: Properties%>" /></a></li>
          </ul>
        </div>
        <ul id="formsettings" class="tab">
          <li style="display:none;">
            <label><asp:localize runat="server" text="<%$ LemoonResources: ClassName%>" /></label>
            <div><input type="text" name="setting_name" id="setting_name" value="<%=_name %>" /></div>
          </li>
          <li>
            <label><asp:localize runat="server" text="<%$ LemoonResources: DisplayName%>" /></label>
            <div><input type="text" name="setting_displayname" id="setting_displayname" value="<%=_displayName %>" /></div>
          </li>
          <li>
            <label><asp:localize runat="server" text="<%$ LemoonResources: Description%>" /></label>
            <div><input type="text" name="setting_description" id="setting_description" value="<%=_description %>" /></div>
          </li>
          <li style="display:none;">
            <label><asp:localize runat="server" text="<%$ LemoonResources: Namespace%>" /></label>
            <div><input type="text" name="setting_namespace" id="setting_namespace" value="<%=_namespace %>" readonly="readonly" /></div>
          </li>
          <li id="labelPlacement" runat="server">
            <label><asp:localize runat="server" text="<%$ LemoonResources: LabelPlacement%>" /></label>
            <div>
              <select id="setting_alignment" name="setting_alignment">
                <option <%=_alignment == "" ? "selected" : "" %> value=""><asp:localize runat="server" text="<%$ LemoonResources: TopAligned%>" /></option>
                <option <%=_alignment == "leftLabel" ? "selected" : "" %> value="leftLabel"><asp:localize runat="server" text="<%$ LemoonResources: LeftAligned%>" /></option>
                <option <%=_alignment == "rightLabel" ? "selected" : "" %> value="rightLabel"><asp:localize runat="server" text="<%$ LemoonResources: RightAligned%>" /></option>
              </select>
            </div>
          </li>
        </ul>
        <ul id="formfields" class="tab">
          <asp:repeater id="controls" runat="server" onitemdatabound="controls_ItemDataBound">
            <itemtemplate><asp:literal id="item" runat="server" /></itemtemplate>
          </asp:repeater>
        </ul>
        <div id="properties" class="tab">
          <ul>
            <li>
              <label><asp:localize runat="server" text="<%$ LemoonResources: PropertyName%>" /></label>
              <div><input id="field_id" type="text" /></div>
            </li>
            <li>
              <label><asp:localize runat="server" text="<%$ LemoonResources: Label%>" /></label>
              <div><input id="field_label" type="text" /></div>
            </li>
            <li>
              <label><asp:localize runat="server" text="<%$ LemoonResources: Description%>" /></label>
              <div><input id="field_description" type="text" /></div>
            </li>
            <li id="alignment" runat="server">
              <label><asp:localize runat="server" text="<%$ LemoonResources: Alignment%>" /></label>
              <div>
                <select id="field_alignment">
                  <option value=""><asp:localize runat="server" text="<%$ LemoonResources: AlignNone%>" /></option>
                  <option value="two1"><asp:localize runat="server" text="<%$ LemoonResources: AlignTwoFirst%>" /></option>
                  <option value="two2"><asp:localize runat="server" text="<%$ LemoonResources: AlignTwoSecond%>" /></option>
                  <option value="three1"><asp:localize runat="server" text="<%$ LemoonResources: AlignThreeFirst%>" /></option>
                  <option value="three2"><asp:localize runat="server" text="<%$ LemoonResources: AlignThreeSecond%>" /></option>
                  <option value="three3"><asp:localize runat="server" text="<%$ LemoonResources: AlignThreeThird%>" /></option>
                </select>
              </div>
            </li>
            <li id="cssName" runat="server">
              <label><asp:localize runat="server" text="<%$ LemoonResources: CssClass%>" /></label>
              <div><input id="field_cssclass" type="text" /></div>
            </li>
            <li id="layoutCss" runat="server">
              <label><asp:localize runat="server" text="<%$ LemoonResources: FieldLayout%>" /></label>
              <div>
                <select id="field_layout">
                </select>
              </div>
            </li>
            <li id="showForDisplay" runat="server">              
              <input id="field_showfordisplay" type="checkbox" class="checkbox" checked="checked" /><label for="field_showfordisplay"><asp:localize runat="server" text="<%$ LemoonResources: ShowForDisplay%>" /></label>
            </li>
            <li id="showForEdit" runat="server">
              <input id="field_showforedit" type="checkbox" class="checkbox" checked="checked" /><label for="field_showforedit"><asp:localize runat="server" text="<%$ LemoonResources: ShowForEdit%>" /></label>
            </li>
            <li id="exportTitle" runat="server">
              <label><asp:localize runat="server" text="<%$ LemoonResources: ExportTitle%>" /></label>
              <div><input type="text" id="field_exporttitle" value="" /></div>
            </li>
          </ul>
          <ul id="customproperties"></ul>
        </div>

        <div id="progress"></div>

        <div style="clear:left;"></div>

        <div class="vertical">
        <lemoon:buttons runat="server" >
          <lemoon:htmlbutton id="save" runat="server" text="<%$ LemoonResources: Save%>" onclientclick="LemoonDesigner.SubmitForm();" shortcut="Ctrl+Shift+S" />
          <lemoon:anchor id="cancel" href="~/admin/manage/content/default.aspx" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
        </lemoon:buttons>
        </div>
                
      </div>      
      
    </div>

    <div class="htmleditor">
      <div class="title">Test</div>
      <lemoon:tinymce id="html" runat="server" width="650px" height="300px" />
      <a href="javascript:void(0);" onclick="LemoonDesigner.SaveHtmlField();"><asp:localize id="Localize1" runat="server" text="<%$ LemoonResources: Save%>" /></a> <asp:localize id="Localize2" runat="server" text="<%$ LemoonResources: ButtonsOr%>" />
      <a id="cancelPopup" runat="server" href="javascript:void(0);"><asp:localize id="Localize3" runat="server" text="<%$ LemoonResources: Cancel%>" /></a>
    </div>
  <lemoon:popup id="popup" runat="server">
  </lemoon:popup>

  <script type="text/javascript">
    $(document).ready(function () {
      // Scrolls the property window on large forms.
      $(window).scroll(function () {
        if ($(window).scrollTop() > $(".scrollIdentifier").offset().top) {
          //alert($("#aside").height() + ' - ' + $(window).height());
          if ($("#stage").height() > $(window).height() && $("#aside").height() < $(window).height()) {
            $("#aside").css("position", "fixed");
            $("#aside").css("top", "0");
            $(".htmleditor").css("position", "fixed");
          }
        }

        if ($(window).scrollTop() <= $(".scrollIdentifier").offset().top) {
          $("#aside").css("position", "relative");
          $("#aside").css("top", $(".scrollIdentifier").offset);
          $(".htmleditor").css("position", "fixed");
          $('.htmleditor').css("top", $(".scrollIdentifier").offset().top - 90);
        }
      });
    });
  </script>

</asp:content>
