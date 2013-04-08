<%@ page language="C#" autoeventwireup="false" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Manage._System.Default" masterpagefile="~/admin/master/main.master" enableeventvalidation="false" %>

<asp:content contentplaceholderid="submenu" runat="server">
  <lemoon:managemenu runat="server" />
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
   
  <lemoon:panel id="about" runat="server" visible="false">  
    <h3><asp:localize runat="server" text="<%$ LemoonResources: Version %>" /></h3>
    <p>
    Mindroute.Core: <asp:literal id="coreVersion" runat="server" /><br />
    Mindroute.Lemoon: <asp:literal id="lemoonVersion" runat="server" />
    </p>

    <h3><asp:localize runat="server" text="<%$ LemoonResources: License %>" /></h3>
    <p>
    <asp:localize runat="server" text="<%$ LemoonResources: LicenseKey %>" />: <asp:literal id="licenseKey" runat="server" /><br />
    <asp:localize runat="server" text="<%$ LemoonResources: LicenseRegisteredTo %>" />: <asp:literal id="licenseIssuedTo" runat="server" /><br />
    <asp:localize runat="server" text="<%$ LemoonResources: LicenseExpires %>" />: <asp:literal id="licenseExpires" runat="server" /><br />
    <asp:localize runat="server" text="<%$ LemoonResources: Support %>" />: <asp:literal id="support" runat="server" />
    </p>

    <lemoon:buttons id="buttons" runat="server">
      <lemoon:button onclick="update_Click" runat="server" text="<%$ LemoonResources: Update %>" />
      <lemoon:anchor href="~/admin/upgrade/license.aspx" text="<%$ LemoonResources: Change %>" runat="server" />
    </lemoon:buttons>
  </lemoon:panel>
     
  
 <% if (Tab == "usage") { %>
  <div class="tab">
    <h3><%= Mindroute.Lemoon.Properties.Resources.RepositoryUsage %></h3>
    <p>
    <%= Mindroute.Lemoon.Properties.Resources.DatabaseUsage %>: <asp:literal id="repoSize" runat="server" /><br />
    <%= Mindroute.Lemoon.Properties.Resources.BlobsUsage %>: <asp:literal id="blobSize" runat="server" />
    </p>

    <h3><%= Mindroute.Lemoon.Properties.Resources.FullTextIndex %></h3>
    <p>
    <%= Mindroute.Lemoon.Properties.Resources.FullTextItems %>: <asp:literal id="indexCount" runat="server" />
    <span id="indexFunctions" runat="server" visible="false" class="functions">(<lemoon:linkbutton id="rebuildIndex" runat="server" onclick="rebuildIndex_Click" />, <lemoon:linkbutton id="optimizeIndex" runat="server" onclick="optimizeIndex_Click" />)</span>
    </p>

    <h3><%= Mindroute.Lemoon.Properties.Resources.CacheInfo %></h3>
    <p>
    <%= Mindroute.Lemoon.Properties.Resources.ClearCacheFunction_ItemsInCache_Name %>: <asp:literal id="cacheCount" runat="server" />
    <span id="cacheFunctions" runat="server" visible="false" class="functions">(<lemoon:linkbutton id="clearCache" runat="server" onclick="clearCache_Click" />)</span><br />
    <%= Mindroute.Lemoon.Properties.Resources.HitRatio %>: <asp:literal id="hitRatio" runat="server" />
    </p>
  </div>
<% } %>  

</asp:content>
