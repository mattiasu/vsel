<%@ Page Title="" Language="C#" MasterPageFile="~/Lemoon/MasterPages/Vsel.Master" AutoEventWireup="true" CodeBehind="StartPage.aspx.cs" Inherits="vsel.Lemoon.Templates.StartPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EndOfHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
    <div class="twelve columns">
      <div id="slider">
        <% foreach (var image in Content.SliderImages) { %>
            <img src="<%: image.Url() %>" alt="" />
          <%} %>
      </div>
      <hr />
    </div>
  </div>

    <!-- Three-up Content Blocks -->
  
  <div class="row">
  
    <div class="four columns">
      <img src="<%= Content.ColImages.First().Url() %>" />
      <h4><%= (Content.ColPages.First().Value).Title %></h4>
      <p><%= (Content.ColPages.First().Value).Teaser.Ellipsis(250) %>
          <br /><a href="<%= (Content.ColPages.First().Value).Url(false) %>">Läs mer</a>
      </p>
      
    </div>
    
    <div class="four columns">
      <img src="<%= Content.ColImages.Skip(1).First().Url() %>" />
      <h4><%= (Content.ColPages.Skip(1).First().Value).Title %></h4>
      <p><%= (Content.ColPages.Skip(1).First().Value).Teaser.Ellipsis(250) %>
          <br /><a href="<%= (Content.ColPages.Skip(1).First().Value).Url(false) %>">Läs mer</a>
      </p>
    </div>
    <div class="four columns">
      <img src="<%= Content.ColImages.Skip(2).First().Url() %>" />
      <h4><%= (Content.ColPages.Skip(2).First().Value).Title %></h4>
      <p><%= (Content.ColPages.Skip(2).First().Value).Teaser.Ellipsis(250) %>
          <br /><a href="<%= (Content.ColPages.Skip(2).First().Value).Url(false) %>">Läs mer</a>
      </p>
    </div>
    
  </div>
  
  
  <!-- Call to Action Panel -->
  <div class="row">
    <div class="twelve columns">
    
      <div class="panel">
        <h4>Vill du veta vad vi kan göra för dig?</h4>
            
        <div class="row">
          <div class="nine columns">
            <p>Här skriver man en inbjudande text om att kontakta er.</p>
          </div>
          <div class="three columns">
            <a href="#" class="radius button right">Kontakta oss</a>
          </div>
        </div>
      </div>
      
    </div>
  </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="EndOfBody" runat="server">
    <script type="text/javascript">
        $(window).load(function () {
            $('#slider').orbit();
        });
  </script>
</asp:Content>
