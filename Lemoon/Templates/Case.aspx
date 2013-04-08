<%@ Page Title="" Language="C#" MasterPageFile="~/Lemoon/MasterPages/Vsel.Master" AutoEventWireup="true" CodeBehind="Case.aspx.cs" Inherits="vsel.Lemoon.Templates.Case" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
    <div class="large-8 columns">
        <h4><%= Content.Title %></h4>
        <%= Content.Body %>
    </div>
  </div>

  <div class="row">
      <% if(Content.QuoteImage.HasValue()){ %>
    <div class="four columns">
      <img src="<%= Content.QuoteImage.Url(false) %>" alt="">
    </div>
      <%} %>
    <div class="eight columns">
      <span class="quote"><%= Content.QuoteText.HtmlSafe(true) %></span>
    </div>
  </div>
  <div class="row">
    <div class="eight columns">
        <h4><%= Content.SecondaryTitle %></h4>
        <%= Content.SecondaryBody %>
    </div>
    <% if(Content.SecondaryImage.HasValue()){ %>
      <div class="four columns">
      <img src="<%= Content.SecondaryImage.Url(false) %>">
    </div>
      <%} %>
  </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="EndOfBody" runat="server">
</asp:Content>
