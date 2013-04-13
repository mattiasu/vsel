<%@ Page Title="" Language="C#" MasterPageFile="~/Lemoon/MasterPages/Vsel.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="vsel.Lemoon.Templates.AboutUs" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="row">
        <div class="eight columns">
            <h4><%= Content.Title %></h4>

            <%= Content.Body %>

    </div>
    <div class="four columns">
        <div class="panel">
            <h4><%= Content.RightColTitle %></h4>
            <%= Content.Address.HtmlSafe(true) %>
         </div>
    </div>
  </div>
    <div id="map-canvas">
        <iframe src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=sv&amp;geocode=&amp;q=Gustaf+Werners+gata+8B,+V%C3%A4stra+Fr%C3%B6lunda,+Sverige&amp;aq=0&amp;oq=Gustaf+Werners+gata+8B&amp;sll=37.996163,-95.712891&amp;sspn=58.522914,129.814453&amp;ie=UTF8&amp;hq=&amp;hnear=Gustaf+Werners+gata+8B,+421+32+V%C3%A4stra+Fr%C3%B6lunda,+Sverige&amp;t=m&amp;z=14&amp;iwloc=r0&amp;ll=57.652421,11.950106&amp;output=embed"></iframe>
    </div>
    <div class="row" style="text-align:center;">
        <h1><img src="http://placehold.it/400x100&text=Logo" /></h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="EndOfBody" runat="server">
</asp:Content>
