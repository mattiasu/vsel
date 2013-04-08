<%@ page language="C#" autoeventwireup="true" codebehind="allowedchildren.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.AllowedChildren" masterpagefile="~/admin/master/main.master" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <lemoon:fieldset id="fieldset" runat="server" buttontext="<%$ LemoonResources: AllowedChildren%>">

    <lemoon:radiobuttonsfield id="category" runat="server" label="<%$ LemoonResources: AllowedChildren%>" repeatdirection="Horizontal" />

    <div class="field">
      <label>&nbsp;</label>
      <ul class="group" id="allowedChildren" runat="server" />
    </div>

    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" onclick="save_Click" shortcut="Ctrl+Shift+S" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
    </lemoon:buttons>
  </lemoon:fieldset>
  <script type="text/javascript">

    $("document").ready(function() {
      changeMode();
      $(".tab .field").eq(0).css("border-bottom", "0px");
      $(".tab").find("input[type='radio']").change(function() {
        changeMode();
      });
    });

    function changeMode() {
      if ($("input[name='<%=category.UniqueID%>$f']:checked").val() == 3) {
        $(".tab").find("input[type='checkbox']").each(function() {
          $(this).removeAttr("disabled");
        });
      } else {
        $(".tab").find("input[type='checkbox']").each(function(index) {
          $(this).attr("disabled", "disabled");
        });
      }      
    } 
  </script>
</asp:content>