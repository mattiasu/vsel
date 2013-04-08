<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="edit.aspx.cs" inherits="Mindroute.Lemoon.Admin.Comments.Edit" masterpagefile="~/admin/master/main.master" enableviewstate="false" %>
<%@ import namespace="Mindroute.Lemoon.Helpers" %>

<asp:content contentplaceholderid="submenu" runat="server">

</asp:content>

<asp:content contentplaceholderid="content" runat="server">

    <lemoon:fieldset id="edit" runat="server">     
      <lemoon:textfield id="name" runat="server" label="<%$ LemoonResources: Name%>" required="true" />
      <lemoon:emailfield id="email" runat="server" label="<%$ LemoonResources: Email%>" required="true" />
      <lemoon:urlfield id="url" runat="server" label="<%$ LemoonResources: Url%>" />
      <lemoon:textfield id="text" runat="server" label="<%$ LemoonResources: Comment%>" textmode="MultiLine" required="true" />
      <lemoon:radiobuttonsfield id="status" runat="server" label="<%$ LemoonResources: Status%>" repeatdirection="Horizontal" />
    </lemoon:fieldset> 

    <lemoon:buttons runat="server">
      <lemoon:button id="save" runat="server" text="<%$ LemoonResources: Save%>" shortcut="Ctrl+Shift+S" onclick="save_Click" />
      <lemoon:linkbutton id="delete" runat="server" text="<%$ LemoonResources: Delete%>" onclick="delete_Click" visible="false" />
      <lemoon:anchor id="cancel" runat="server" text="<%$ LemoonResources: Cancel%>" shortcut="Esc" />
    </lemoon:buttons>
      
</asp:content>
