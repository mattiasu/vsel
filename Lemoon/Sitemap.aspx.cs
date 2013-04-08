using System.Globalization;
using System.Web.UI;
using Mindroute.Core.Model;
using Mindroute.Lemoon.Helpers;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon
{

    /// <summary>
    /// Renders an XML sitemap for search engines.
    /// </summary>
    public partial class Sitemap : PageBase
    {

        protected override void Render(HtmlTextWriter writer)
        {
            base.Render(writer);

            writer.WriteLine(@"<?xml version=""1.0"" encoding=""UTF-8"" ?>");
            writer.WriteBeginTag("urlset");
            writer.WriteAttribute("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9");
            writer.WriteLine(HtmlTextWriter.TagRightChar);
            writer.Indent++;
            var items = ContentService.GetSitemap(Site.ID, displayInMenu: DisplayInMenu.Sitemap);
            foreach (var item in items)
            {
                writer.WriteFullBeginTag("url");
                writer.Indent++;
                writer.WriteLine();

                writer.WriteFullBeginTag("loc");
                writer.Write(item.Url(true));
                writer.WriteEndTag("loc");
                writer.WriteLine();

                writer.WriteFullBeginTag("lastmod");
                writer.Write(item.Modified.ToString("yyyy-MM-dd"));
                writer.WriteEndTag("lastmod");
                writer.WriteLine();

                if (!string.IsNullOrEmpty(item.ChangeFrequency()))
                {
                    writer.WriteFullBeginTag("changefreq");
                    writer.Write(item.ChangeFrequency());
                    writer.WriteEndTag("changefreq");
                    writer.WriteLine();
                }

                if (item.Priority().HasValue)
                {
                    writer.WriteFullBeginTag("priority");
                    writer.Write(item.Priority().Value.ToString("f1", CultureInfo.InvariantCulture));
                    writer.WriteEndTag("priority");
                    writer.WriteLine();
                }

                writer.Indent--;
                writer.WriteEndTag("url");
                writer.WriteLine();
            }
            writer.Indent--;
            writer.WriteEndTag("urlset");
        }
    }
}