<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="feed.ascx.cs" Inherits="Mindroute.Lemoon.Admin.Controls.Feed" %>

<lemoon:textfield id="title" runat="server" label="<%$ LemoonResources:Feed_Title_Name%>" description="<%$ LemoonResources:Feed_Title_Description%>" />
<lemoon:textfield id="description" runat="server" label="<%$ LemoonResources:Feed_Description_Name%>" description="<%$ LemoonResources:Feed_Description_Description%>" />
<lemoon:contentfield id="image" runat="server" label="<%$ LemoonResources:Feed_Image_Name%>" description="<%$ LemoonResources:Feed_Image_Description%>" pickers="Files" />
<lemoon:checkboxesfield id="feeds" runat="server" label="<%$ LemoonResources:Feeds%>" description="<%$ LemoonResources:Feeds_Description %>" />
<lemoon:booleanfield id="showfull" runat="server" label="<%$ LemoonResources:Feed_ShowFull_Name%>" description="<%$ LemoonResources:Feed_ShowFull_Description%>" />
<lemoon:radiobuttonsfield id="format" runat="server" label="<%$ LemoonResources:Feed_Format%>" description="<%$ LemoonResources:Feed_Format_Description%>" repeatdirection="Horizontal" />