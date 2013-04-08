<%@ page language="C#" autoeventwireup="true" codebehind="default.aspx.cs" inherits="Mindroute.Lemoon.Admin.Install.Default" masterpagefile="~/admin/master/simple.master" enableviewstate="false" %>

<asp:content contentplaceholderid="content" runat="server">

  <fieldset>
    <legend><%= Mindroute.Lemoon.Properties.Resources.SetupLemoon %></legend>
    <p class="description">
     <% if (!Passed) { %>
     <%= Mindroute.Lemoon.Properties.Resources.RequirementsDescription %>
     <% } else { %>
     <%= Mindroute.Lemoon.Properties.Resources.ConfigureDescription %>
     <% } %>
    </p>

    <% if (!Passed) { %>
    <ul class="checks">
    <% foreach (var check in Checks) { %>
      <li class="<%= check.Status.ToString().ToLower() %>">
        <span class="icon-12 <% if (check.Status == Mindroute.Core.Model.CheckStatus.Failed) { %>red deny <%} else if (check.Status == Mindroute.Core.Model.CheckStatus.Passed) {  %>green allow<% } else { %>none<% } %>"></span><%= check.Text.HtmlSafe() %>
        <% if (check.FailureMessage != null) { %>
        <span class="message"><%= check.FailureMessage.HtmlSafe()%></span>
        <% } %>
      </li>     
    <% } %>
    </ul>
    <lemoon:button id="checkButton" runat="server" text="<%$ LemoonResources: CheckAgain %>" onclick="check_Click" />
    <% } %>

    <lemoon:textfield id="sitename" runat="server" label="<%$ LemoonResources: DefaultSiteName%>" description="<%$ LemoonResources: DefaultSiteNameDescription%>" required="true" />
    <lemoon:selectfield id="language" runat="server" label="<%$ LemoonResources: DefaultSiteLanguage%>" description="<%$ LemoonResources: DefaultSiteLanguageDescription%>" required="true" />
    <div class="field" id="scaffoldfield" runat="server">
      <label><%= Mindroute.Lemoon.Properties.Resources.SiteContent %></label>
      <div class="group">
        <span class="checkbox"><asp:checkbox id="scaffold" runat="server" text="<%$ LemoonResources: CreateSiteContent %>" checked="true" /></span>
      </div>
      <div class="info"><%= Mindroute.Lemoon.Properties.Resources.SiteContentDescription %></div>
    </div>
    <lemoon:textfield id="username" runat="server" label="<%$ LemoonResources: InstallUsername %>" description="<%$ LemoonResources: InstallUsernameDescription%>" required="true" />
    <lemoon:passwordfield id="password" runat="server" label="<%$ LemoonResources: InstallPassword%>" description="<%$ LemoonResources: InstallPasswordDescription%>" required="true" />
    <lemoon:passwordfield id="repeatpassword" runat="server" label="<%$ LemoonResources: RepeatInstallPassword%>" required="true" />
    <lemoon:buttons runat="server">
      <lemoon:button id="setupButton" runat="server" text="<%$ LemoonResources: Setup %>" onclick="setup_Click" default="true" />
    </lemoon:buttons>  
  </fieldset>
  
</asp:content>
