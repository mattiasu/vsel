<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="default.ascx.cs" Inherits="Mindroute.Lemoon.Admin._Content._View.Default" %>
<%@ register tagprefix="lemoon" tagname="comments" src="~/admin/controls/comments.ascx" %>
<%@ register tagprefix="lemoon" tagname="children" src="~/admin/controls/children.ascx" %>
<asp:literal id="fields" runat="server" />

<lemoon:anchor id="back" cssclass="back" runat="server" visible="false" />
<lemoon:children runat="server" />
<lemoon:comments runat="server" />