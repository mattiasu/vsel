<%@ page language="C#" autoeventwireup="true" codebehind="sort.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Sort" masterpagefile="~/admin/master/main.master" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server" description="<%$ LemoonResources: SortDescription%>">
    <lemoon:selectfield id="sortcolumn" runat="server" label="<%$ LemoonResources: SortAttribute%>" description="<%$ LemoonResources: SortAttributeDescription%>" />
    <lemoon:selectfield id="sortdirection" runat="server" label="<%$ LemoonResources: SortOrder%>" />
    <div id="manualsort" runat="server" class="field">
      <label><asp:localize runat="server" text="<%$ LemoonResources: SortManual%>" /></label>
      <div style="float:left;">
      <asp:repeater id="pages" runat="server">
        <headertemplate>
          <ol id="sortable">
        </headertemplate>
        <itemtemplate>
          <li <%#((Mindroute.Core.Model.Content)Container.DataItem).IsLocked ? @" class=""locked""" : "" %>>
            <span class="icon-12 sort"></span>
            <span class="title"><%#((Mindroute.Core.Model.Content)Container.DataItem).ShortTitle ?? ((Mindroute.Core.Model.Content)Container.DataItem).Title.Ellipsis(64)%></span>
            <input type="hidden" name="content" value="<%#((Mindroute.Core.Model.Content)Container.DataItem).ID%>" />
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
        <asp:localize runat="server" text="<%$ LemoonResources: ChangesMadeToTable%>" /></p>
    </div>
    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="save_Click" shortcut="Ctrl+Shift+S" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>

  <script type="text/javascript">
    $(document).ready(function () {
      togglesort();

      function togglesort() {
       var val = $("#<%=sortcolumn.ClientID%>_f").val();
        if (val == '') {
          $("#<%=manualsort.ClientID%>").hide();
          $("#<%=sortdirection.ClientID%>_f").parent().hide();
        } else if (val == '<%=Mindroute.Core.Search.ContentColumn.Weight.ToString()%>') {
          $("#<%=manualsort.ClientID%>").show();
          $("#<%=sortdirection.ClientID%>_f").parent().hide();
        } else {
          $("#<%=manualsort.ClientID%>").hide();
          $("#<%=sortdirection.ClientID%>_f").parent().show();
        }
      }

      $("#<%=sortcolumn.ClientID%>_f").change(function () {
        togglesort();
      });

      $("#sortable").sortable({
        placeholder: 'sortplaceholder',
        handle: 'span',
        axis: 'y',
        forcePlaceholderSize: true,
        forceHelperSize: true,
        update: function (event, ui) {
          $("#sortinfo").show();
        }
      });
    });
  </script>

</asp:content>