<%@ Page Title="" Language="C#" MasterPageFile="~/Lemoon/MasterPages/Vsel.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="vsel.Lemoon.Templates.AboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EndOfHeader" runat="server">
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script>
        var map;
        var latlng = new google.maps.LatLng(57.652421, 11.950106);

        function initialize() {
            var mapOptions = {
                zoom: 8,
                center: latlng,
                scrollwheel: false,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            map = new google.maps.Map(document.getElementById('map-canvas'),
                mapOptions);

            var marker = new google.maps.Marker({
                position: latlng,
                map: map,
                title: 'Västsvenska Elbolaget'
            });

            var infowindow = new google.maps.InfoWindow({
                content: contentString
            });
        }
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="row">
        <div class="eight columns">
            <h4><%= Content.Title %></h4>

            <%= Content.Body %>

    </div>
    <div class="four columns">
        <h4><%= Content.RightColTitle %></h4>
        <%= Content.Address.HtmlSafe(true) %>
    </div>
  </div>
    <div id="map-canvas"></div>
    <div class="row" style="text-align:center;">
        <h1><img src="http://placehold.it/400x100&text=Logo" /></h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="EndOfBody" runat="server">
</asp:Content>
