<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="visibility.ascx.cs" Inherits="Mindroute.Lemoon.Admin.Controls.Visibility" %>

<lemoon:radiobuttonsfield id="showinmenu" runat="server" label="<%$ LemoonResources: DisplayInMenu%>" description="<%$ LemoonResources: DisplayInMenuDescription%>" visible="false" />
<lemoon:radiobuttonsfield id="searchable" runat="server" label="<%$ LemoonResources: IncludeInSearch%>" description="<%$ LemoonResources: IncludeInSearchDescription%>" />
<lemoon:datetimefield id="from" runat="server" label="<%$ LemoonResources: VisibleFrom%>" description="<%$ LemoonResources: VisibleFromDescription%>" visible="false" />
<lemoon:datetimefield id="to" runat="server" label="<%$ LemoonResources: VisibleTo%>" description="<%$ LemoonResources: VisibleToDescription%>" visible="false" />
<lemoon:booleanfield id="visible" runat="server" label="<%$ LemoonResources: Visible%>" description="<%$ LemoonResources: VisibleDescription%>" value="true" />
