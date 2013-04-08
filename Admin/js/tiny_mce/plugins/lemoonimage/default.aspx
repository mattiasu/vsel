<%@ page language="C#" masterpagefile="~/admin/master/window.master" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.TinyMCE.Plugins.LemoonImage.Default" %>
<%@ import namespace="Mindroute.Core.Model" %>

<asp:content contentplaceholderid="head" runat="server">
  <link type="text/css" href="css/lemoonimage.css" rel="stylesheet" media="screen" />
  <link type="text/css" href="<%=ResolveUrl("~/admin/theme/default/jquery.Jcrop.css") %>" rel="stylesheet" media="screen" />
  <script type="text/javascript" src="../../tiny_mce_popup.js"></script>
  <script type="text/javascript" src="../../utils/validate.js"></script>
  <script type="text/javascript" src="../../utils/form_utils.js"></script>
  <script type="text/javascript" src="js/lemoonimage.js"></script>
  <script type="text/javascript" src="<%=ResolveUrl("~/admin/js/jquery.Jcrop.min.js") %>"></script>
</asp:content>

<asp:content contentplaceholderid="topmenu" runat="server">
  <span class="icon-24 site"></span>
  <%= Mindroute.Lemoon.Properties.Resources.SelectedSite %>
  <lemoon:menu id="sitemenu" runat="server" />
  <form method="get">
    <% foreach (KeyValuePair<string, string> p in Params.Where(x => x.Key != "tab")) { %>  
    <input type="hidden" name="<%= p.Key %>" value="<%= p.Value %>" />
    <% } %> 
    <input id="q" type="text" name="q" value="<%= Query %>"><span class="icon-24 search"></span>
  </form>
</asp:content>

<asp:content contentplaceholderid="content" runat="server">
<% if (Tab == "browse") { %>
  <div id="wrap">
    <div id="content" class="grid-9">
      <% if (Files.Count == 0) {%>
        <p><%= Mindroute.Lemoon.Properties.Resources.NoFilesFound %></p>
      <% } else { %>

        <% if (View == "details") { %>
        <table class="list">
          <col width="200" />
          <col width="*"/>
          <col width="105" />
          <col width="95" />
          <thead >
            <tr>
              <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
              <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Description %></th>
              <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Dimensions %></th>
              <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Size %></th>
            </tr>
          </thead>
          <tbody>
           <% int i = 0; foreach (var item in Files) { %>
            <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
              <td class="ellipsis"><a href="default.aspx?<%= ToQueryString(Params.Where(x => x.Key != "src" && x.Key != "tab"), "src", GetLink(item)) %>" title="<%= Mindroute.Lemoon.Properties.Resources.Insert + " " + GetLink(item) %>"><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Name.HtmlSafe()%></span></a></td>
              <td class="ellipsis"><%= item["Description"] %></td>
              <td class="actions"><%= item.Dimensions() %></td>
              <td class="actions"><%= item.Size.FileSizeAsString() %></td>
            </tr>
            <% } %>
          </tbody> 
        </table>
        <% } else { %>

        <div class="thumbs">
          <% foreach (var item in Files) { %>
            <%= Mindroute.Lemoon.Web.UI.Admin.HtmlFragment.Thumbnail(item, "default.aspx?" + ToQueryString(Params.Where(x => x.Key != "src" && x.Key != "tab"), "src", GetLink(item)), null, null, Mindroute.Lemoon.Properties.Resources.Insert + " " + GetLink(item), false, true, false, true, null)%>
          <% } %>
        </div>

        <% } %>

      <div class="pager">
        <lemoon:pagenumbers id="pagenumbers" runat="server" />
        <lemoon:pagesizer id="pagesizer" runat="server" />
      </div>
      <% } %>
    </div>
    <div id="aside" class="grid-3">
      <lemoon:treeview id="tree" runat="server" />
    </div>
    <div class="clear"></div>
  </div>

<% } else if (Tab == "result") { %>

  <% if (Files.Count <= 0) {%>
  <p><%= Mindroute.Lemoon.Properties.Resources.NoResults%></p>
  <% } else {  %>

  <% if (View == "details") { %>
  <table class="list">
    <col width="250" />
    <col width="*"/>
    <col width="95" />
    <col width="105" />
    <col width="95" />
    <thead >
      <tr>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Name %></th>
        <th class="ellipsis"><%= Mindroute.Lemoon.Properties.Resources.Description %></th>
        <th><%= Mindroute.Lemoon.Properties.Resources.Created %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Dimensions %></th>
        <th class="actions"><%= Mindroute.Lemoon.Properties.Resources.Size %></th>
      </tr>
    </thead>
    <tbody>
      <% int i = 0; foreach (var item in Files) { %>
      <tr<% if (i++ % 2 != 0) {%> class="alt"<% } %>>
        <td class="ellipsis"><a href="default.aspx?<%= ToQueryString(Params.Where(x => x.Key != "src" && x.Key != "tab"), "src", GetLink(item)) %>" title="<%= Mindroute.Lemoon.Properties.Resources.Insert + " " + GetLink(item) %>"><span class="icon-12 <%= item.ContentType.Icon ?? item.ContentType.Name.ToLower() %>"></span><span class="title"><%= item.Name.HtmlSafe()%></span></a></td>
        <td class="ellipsis"><%= item["Description"] %></td>
        <td><%= item.Created.ToText() %></td>
        <td class="actions"><%= item.Dimensions() %></td>
        <td class="actions"><%= item.Size.FileSizeAsString() %></td>
      </tr>
      <% } %>
    </tbody> 
  </table>
  <% } else {  %>

  <div class="thumbs">
    <% foreach (var item in Files) { %>
    <%= Mindroute.Lemoon.Web.UI.Admin.HtmlFragment.Thumbnail(item, "default.aspx?" + ToQueryString(Params.Where(x => x.Key != "src" && x.Key != "tab"), "src", GetLink(item)), null, null, Mindroute.Lemoon.Properties.Resources.Insert + " " + GetLink(item), false, true, false, true, null)%>
    <% } %>
  </div>

  <% } %>
  <div class="pager">
    <lemoon:pagenumbers id="pagenumbers2" runat="server" />
    <lemoon:pagesizer id="pagesizer2" runat="server" />
  </div>
  <% } %>

<% } else if (Tab == "upload") { %>

<lemoon:fieldset runat="server">
  <lemoon:folderfield id="destination" runat="server" label="<%$ LemoonResources: TargetFolder%>" required="true" />
  <lemoon:uploadfield id="file" runat="server" label="<%$ LemoonResources: UploadFile%>" required="true" />  
  <lemoon:textfield id="description" runat="server" label="<%$ LemoonResources: Description %>" />
  <lemoon:buttons runat="server">
    <lemoon:button id="upload" runat="server" text="<%$ LemoonResources: Upload %>" onclick="Upload_Click" />
  </lemoon:buttons>
</lemoon:fieldset>

<% } else { %>

  <div class="field">
    <label for="src"><%= Mindroute.Lemoon.Properties.Resources.Url %></label>
    <input id="src" name="src" type="text" value="<%= Src %>" />
    <% if (SelectedContent != null) { %>
    <%= Mindroute.Lemoon.Web.UI.Admin.HtmlFragment.Thumbnail(SelectedContent, null, null, null, null, false, false, false, false, null)%>
    <% } %>
  </div>
  
  <div class="field">
    <label for="alt"><%= Mindroute.Lemoon.Properties.Resources.Description %></label>
    <input id="alt" name="alt" type="text" value="<%= string.IsNullOrEmpty(Alt) && SelectedContent != null ? SelectedContent["Description"] : Alt %>" />
  </div>

   <% if (FileType != "video") { %>
  <div class="field">
    <label for="class"><%= Mindroute.Lemoon.Properties.Resources.CssClass%></label>
    <input id="class" name="class" type="text" value="<%= Class %>" />
  </div>
   <% } %>

  <% if (SelectedContent == null || FileType != "") { %>
  <div class="field">
    <label for="width"><%= Mindroute.Lemoon.Properties.Resources.Alignment %></label>
    <div class="group">
        <input type="radio" name="align" id="align-none" value=""<% if (Align == "align-none"){ %> checked="checked"<%} %> />
        <label for="align-none" class="align none"><%= Mindroute.Lemoon.Properties.Resources.Alignment_None %></label>

        <input type="radio" name="align" id="align-left" value="align-left"<% if (Align == "align-left"){ %> checked="checked"<%} %> />
        <label for="align-left" class="align left"><%= Mindroute.Lemoon.Properties.Resources.Alignment_Left %></label>

        <input type="radio" name="align" id="align-center" value="align-center"<% if (Align == "align-center"){ %> checked="checked"<%} %> />
        <label for="align-center" class="align center"><%= Mindroute.Lemoon.Properties.Resources.Alignment_Center %></label>

        <input type="radio" name="align" id="align-right" value="align-right"<% if (Align == "align-right"){ %> checked="checked"<%} %> />
        <label for="align-right" class="align right"><%= Mindroute.Lemoon.Properties.Resources.Alignment_Right %></label>    
    </div>
  </div>
  <% if (SelectedContent != null) { %>
  <div class="field">
    <label><%= Mindroute.Lemoon.Properties.Resources.Insert%></label>
    <div class="group">
        <input type="radio" name="thumb" id="original" value="original" />
        <label for="original"><%= Mindroute.Lemoon.Properties.Resources.Original %></label>
        <input type="radio" name="thumb" id="thumb" value="thumb" />
        <label for="thumb"><%= Mindroute.Lemoon.Properties.Resources.Thumbnail %></label>
        <% if (!_hideCrop) {%>
        <input type="radio" name="thumb" id="crop" value="crop" />
        <label for="crop"><%= Mindroute.Lemoon.Properties.Resources.Crop%></label>
        <% } %>
    </div> 
    <div class="cropSeparator"></div>
    <label>&nbsp;</label>
    <div class="group croppreview">
      <img src="<%= GetThumb(SelectedContent, 0, _cropThumbHeight) %>" alt="" id="cropImage" height="<%=_cropThumbHeight%>" /><br />
    </div>   
    <div class="group cropsize">
      <table>
        <tr id="cropPos">
          <td><span id="spanCropX">X</span><input type="text" id="cropx" name="cropx" class="size" /></td>
          <td><span id="spanCropY">Y</span><input type="text" id="cropy" name="cropy" class="size" /></td>
        </tr>
        <tr>
          <td><span>W</span><input type="text" id="width" name="width" value="<%= Width %>" class="size" /></td>
          <td><span>H</span><input type="text" id="height" name="height" value="<%= Height %>" class="size" /></td>
        </tr>
        <tr>
          <td colspan="2">
            <a href="javascript:void(0);" onclick="resetValues();"><%= Mindroute.Lemoon.Properties.Resources.Reset %></a>
          </td>
        </tr>
      </table>
    </div>   
  </div>

  <% }
   } %>


  <% if (SelectedContent.IsImage()) { %>
  <input id="thumbsrc" name="thumbsrc" type="hidden" value="<%= GetThumbLink(SelectedContent) %>" />
  <input type="hidden" id="selwidth" name="selwidth" value="<%= GetWidth(SelectedContent) %>" />
  <input type="hidden" id="selheight" name="selheight" value="<%= GetHeight(SelectedContent) %>" />
  <script type="text/javascript">
    var jcropApi = null;
    var isCropped = false;
    $(function () {
      waterMark();

      if (jQuery.browser.webkit == null) { // If not chrome
        jcropApi = $.Jcrop('#cropImage', {
          onSelect: selectCropCoords,
          onChange: selectCropCoords
        });
      }
      if (LemoonCrop.X != 0 && LemoonCrop.Y != 0) {
        showThumb('crop');
        //[ x,y,x2,y2 ]
        if (jQuery.browser.webkit == null) { // If not chrome or safari
          jcropApi.setSelect([
              Number(LemoonCrop.X / LemoonCrop.Ratio),
              Number(LemoonCrop.Y / LemoonCrop.Ratio),
              Number((LemoonCrop.X + Number($("#width").val())) / LemoonCrop.Ratio),
              Number((LemoonCrop.Y + Number($("#height").val())) / LemoonCrop.Ratio)
            ]);
        }
      }
      else if (LemoonCrop.Width != 0 || LemoonCrop.Height != 0) {
        showThumb('thumb');
      }
      else {
        showThumb('');
      }

      $("input[name=thumb]").bind('click', function () {
        showThumb($(this).val());
      });

    });

    function showThumb(type) {
      switch (type) {
        case 'thumb':
          $('#cropPos').hide();
          $('.croppreview').hide();
          $('.cropsize').show();
          $('#thumb').attr('checked','checked')
          break;
        case 'crop':
          $('#cropPos').show();
          $('.croppreview').show();
          $('.cropsize').show();
          $('#crop').attr('checked', 'checked')
          if (!isCropped && jQuery.browser.webkit == true) { // If Chrome or Safari
            jcropApi = $.Jcrop('#cropImage', {
              onSelect: selectCropCoords,
              onChange: selectCropCoords
            });
            jcropApi.setSelect([
              Number(LemoonCrop.X / LemoonCrop.Ratio),
              Number(LemoonCrop.Y / LemoonCrop.Ratio),
              Number((LemoonCrop.X + Number($("#width").val())) / LemoonCrop.Ratio),
              Number((LemoonCrop.Y + Number($("#height").val())) / LemoonCrop.Ratio)
            ]);
            isCropped = true;
          }
          break;
        default:
          $('.croppreview').hide();
          $('.cropsize').hide();
          $('#original').attr('checked', 'checked')
          break;
      }
    }

    function waterMark() {
      $("#width").watermark('<%= GetWidth(SelectedContent) %>');
      $("#height").watermark('<%= GetHeight(SelectedContent) %>');
      $("#cropx").watermark('0');
      $("#cropy").watermark('0');
    }

    function resetValues() {
      jcropApi.release();
      $("#width").val('');
      $("#height").val('');
      $("#cropx").val('');
      $("#cropy").val('');
      waterMark();
    }

    function selectCropCoords(c) {
      LemoonCrop.Width = Math.round(c.w * LemoonCrop.Ratio);
      LemoonCrop.Height = Math.round(c.h * LemoonCrop.Ratio);
      LemoonCrop.X = Math.round(c.x * LemoonCrop.Ratio);
      LemoonCrop.Y = Math.round(c.y * LemoonCrop.Ratio);

      if (LemoonCrop.Width == 0) {
        resetValues();
      }
      else {
        $("#width").val(LemoonCrop.Width);
        $("#height").val(LemoonCrop.Height);
        $("#cropx").val(LemoonCrop.X);
        $("#cropy").val(LemoonCrop.Y);
        $.watermark.hide('#width');
        $.watermark.hide('#height');
        $.watermark.hide('#cropx');
        $.watermark.hide('#cropy');
      }
    };
  </script>
  <% } %>

  <div class="buttons">
    <% if (SelectedContent != null) { %>
    <input type="hidden" id="selsrc" name="selsrc" value="<%= GetLink(SelectedContent) %>" />
    <input type="hidden" id="seltype" name="seltype" value="<%= FileType %>" />
    <input type="hidden" id="seltitle" name="seltitle" value="<%= SelectedContent.Title.HtmlSafe() %>" />
    <% } %>
    <a class="button" onclick="LemoonImageDialog.InsertAction();" href="javascript:void(0);"><span><%= Action == "update" ? Mindroute.Lemoon.Properties.Resources.Update : Mindroute.Lemoon.Properties.Resources.Insert %></span></a>
    <div class="separator"><%= Mindroute.Lemoon.Properties.Resources.ButtonsOr %></div>
    <a class="link" onclick="LemoonImageDialog.Close();" href="javascript:void(0);"><%= Mindroute.Lemoon.Properties.Resources.Cancel %></a>
  </div>

<% } %>
</asp:content>
