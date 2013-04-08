<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="properties.ascx.cs" Inherits="Mindroute.Lemoon.Admin.Controls.Properties" %>

<lemoon:textfield id="slug" runat="server" label="<%$ LemoonResources: Slug%>" description="<%$ LemoonResources: SlugDescription%>" />
<lemoon:textfield id="permalink" runat="server" label="<%$ LemoonResources: Permalink%>" description="<%$ LemoonResources: PermalinkDescription%>" />
<lemoon:selectfield id="template" runat="server" label="<%$ LemoonResources: Template%>" visible="false" />

<lemoon:labelfield id="createdby" runat="server" label="<%$ LemoonResources: CreatedBy%>" visible="false" />
<lemoon:datetimefield id="createdDate" runat="server" label="<%$ LemoonResources: CreatedDate%>"  />
<lemoon:labelfield id="modifiedby" runat="server" label="<%$ LemoonResources: ModifiedBy%>" visible="false" />
<lemoon:labelfield id="modifieddate" runat="server" label="<%$ LemoonResources: ModifiedDate%>" visible="false" />
<lemoon:radiobuttonsfield id="commenting" runat="server" label="<%$ LemoonResources: AllowCommenting%>" visible="false" />
