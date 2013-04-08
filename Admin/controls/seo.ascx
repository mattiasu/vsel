<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="seo.ascx.cs" Inherits="Mindroute.Lemoon.Admin.Controls.SEO" %>

<lemoon:textfield id="metakeywords" runat="server" label="<%$ LemoonResources: Seo_MetaKeywords_Name%>" description="<%$ LemoonResources: Seo_MetaKeywords_Description%>" />
<lemoon:textareafield id="metadescription" runat="server" label="<%$ LemoonResources: Seo_MetaDescription_Name%>" description="<%$ LemoonResources: Seo_MetaDescription_Description%>" height="50px" width="400px" />
<lemoon:selectdoublefield id="prio" runat="server" label="<%$ LemoonResources: Seo_Priority_Name%>" description="<%$ LemoonResources: Seo_Priority_Description%>" value="0.5" />
<lemoon:selectfield id="changefreq" runat="server" label="<%$ LemoonResources: Seo_ChangeFrequency_Name%>" description="<%$ LemoonResources: Seo_ChangeFrequency_Description%>" />
<lemoon:checkboxesfield id="robots" runat="server" label="Meta Robots" />