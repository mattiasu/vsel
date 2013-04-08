<%@ page language="C#" masterpagefile="~/admin/master/main.master" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin._Content.Default" enableviewstate="false" validaterequest="false" %>
<%@ register tagprefix="lemoon" tagname="devinfo" src="~/admin/controls/devinfo.ascx" %>

<asp:content contentplaceholderid="head" runat="server">
  <link type="text/css" href="<%= ThemeService.GetUrl("preview.css") %>" rel="stylesheet" media="screen" />
  <script type="text/javascript" src="<%=ResolveUrl("~/admin/js/embed.js") %>"></script>
  <script type="text/javascript" src="<%=ResolveUrl("~/admin/js/jquery.media.js") %>"></script>
  <script type="text/javascript" src="<%=ResolveUrl("~/admin/js/jquery.metadata.js") %>"></script>
</asp:content>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:contentmenu runat="server" isclipboardactive="true" />
  <lemoon:devinfo runat="server" />
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
  <div id="wrap">
    <div id="content" class="grid-9">
    
      <div class="head">
        <h1><%=Content.Title.HtmlSafe() %></h1>
        <div class="permalink"><asp:literal id="permalink" runat="server" /></div>
        <div class="byline"><asp:literal id="byline" runat="server" /></div>
        <div class="tags" id="tags" runat="server"><asp:localize runat="server" text="<%$ LemoonResources: Tags%>" />: <%=TagService.ToTagString(Content.Tags)%></div>
        <div id="status" runat="server" class="status" visible="false" />

        <lemoon:buttons id="buttons" runat="server">
          <lemoon:htmlbutton id="edit" runat="server" text="<%$ LemoonResources: Edit %>" />
          <lemoon:linkbutton id="undo" runat="server" text="<%$ LemoonResources: UndoChanges%>" visible="false" onclick="undo_Click" />
          <lemoon:button id="accept" runat="server" text="<%$ LemoonResources: Accept%>" visible="false" onclick="accept_Click" addcssclass="alt" />
          <lemoon:linkbutton id="confirm_reject" runat="server" text="<%$ LemoonResources: Reject%>" visible="false" />
        </lemoon:buttons>

        <div class="clear"></div>
      </div>      
      
      <asp:placeholder id="f" runat="server" />
    </div>
    
    <div id="aside" class="grid-3">
      <lemoon:treeview id="tree" runat="server" />
    </div>
    <div class="clear"></div>
  </div>

  <lemoon:contextmenu runat="server" />

  <input type="hidden" id="reasonvalue" name="reasonvalue" value="test" />

  <lemoon:popup id="popup" runat="server">
    <fieldset class="vertical">
      <lemoon:textareafield id="reason" runat="server" label="<%$LemoonResources:RejectReason%>" height="60px" />
      <lemoon:buttons runat="server" cssclass="vertical">
        <lemoon:button id="reject" runat="server" onclick="reject_Click" onclientclick="SetReason();" text="<%$LemoonResources:Reject%>" />
        <lemoon:anchor runat="server" href="javascript:void(0);" onclientclick="$.modal.close();" text="<%$LemoonResources:Cancel%>" />
      </lemoon:buttons>
    </fieldset>
  </lemoon:popup> 
  
  <script type="text/javascript">
   function SetReason() {
      $('#reasonvalue').val($('#<%=reason.ClientID%>_f').val());
    }
    
   function deleteContent(contentID, returnUrl) {
      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "<%=ResolveUrl("~/")%>admin/api/content/delete/?contentID=" + contentID,
        dataType: "json",
        cache: false,
        error: function(XMLHttpRequest, textStatus, errorThrown) {
          alert(textStatus);
        },
        success: function(data, textStatus) {
          if (data.Status == "error") {
            alert(data.Message);
          } else {
            location.href = returnUrl;
          }
        }
      });
    }    

    function removeTranslation(contentID, languageID, returnUrl) {
      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "<%=ResolveUrl("~/")%>admin/api/content/removetranslation/?contentID=" + contentID + "&languageID=" + languageID,
        dataType: "json",
        cache: false,
        error: function(XMLHttpRequest, textStatus, errorThrown) {
          alert(textStatus);
        },
        success: function(data, textStatus) {
          if (data.Status == "error") {
            alert(data.Message);
          } else {
            location.href = returnUrl;
          }
        }
      });
    }    

    $(document).ready(function () {
        $.fn.media.defaults.flvPlayer = '<%= ResolveUrl("~/admin/js/tiny_mce/plugins/lemoonimage/img/player.swf") %>';
        $('a.media').media();
    });
  </script>

</asp:content>
