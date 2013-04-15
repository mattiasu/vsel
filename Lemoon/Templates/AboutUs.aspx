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
    <% if(Content.AboutImage != null){ %>
  <div class="row">
      <div class="twelve columns">
        <img src="<%= Content.AboutImage.Url() %>" alt="" />
      </div>
  </div>
     <%} %>
    <div id="map-canvas">
        <iframe src="https://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=sv&amp;geocode=&amp;q=Gustaf+Werners+gata+8B,+V%C3%A4stra+Fr%C3%B6lunda,+Sverige&amp;aq=0&amp;oq=Gustaf+Werners+gata+8B,+&amp;sll=37.09024,-95.712891&amp;sspn=60.894251,129.814453&amp;ie=UTF8&amp;view=map&amp;cid=9305483912691742631&amp;hq=Gustaf+Werners+gata+8B,+V%C3%A4stra+Fr%C3%B6lunda,+Sverige&amp;hnear=&amp;t=m&amp;iwloc=A&amp;ll=57.652421,11.950106&amp;spn=0.006295,0.006295&amp;z=11&amp;output=embed"></iframe>
    </div>
</asp:Content>
