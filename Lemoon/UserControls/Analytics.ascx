<%@ control language="C#" autoeventwireup="true" codebehind="Analytics.ascx.cs" inherits="vsel.Lemoon.UserControls.Analytics" %>

  <%-- asynchronous google analytics snippet --%>
  <script>
    var _gaq = [['_setAccount', '<%= AnalyticsID %>'], ['_trackPageview']];
    (function (d, t) {
      var g = d.createElement(t), s = d.getElementsByTagName(t)[0];
      g.src = ('https:' == location.protocol ? '//ssl' : '//www') + '.google-analytics.com/ga.js';
      s.parentNode.insertBefore(g, s)
    } (document, 'script'));
  </script>