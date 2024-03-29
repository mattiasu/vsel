﻿using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Mindroute.Core;
using Mindroute.Lemoon.Helpers;
using System.Web.Optimization;

namespace vsel
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            BootStrapper.Start();
            RegisterRoutes(RouteTable.Routes);


            var cssBundle = new StyleBundle("~/bundle/css");
            cssBundle.IncludeDirectory("~/assets/css", ".css", false);

            var scriptBundle = new ScriptBundle("~/bundle/js");
            scriptBundle.Include("~/assets/script/jquery.js",
                "~/assets/script/foundation-min.js", 
                "~/assets/script/app.js");

            BundleTable.Bundles.Add(cssBundle);
            BundleTable.Bundles.Add(scriptBundle);
        }

        protected void Application_End(object sender, EventArgs e)
        {
            BootStrapper.Stop();
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.RouteExistingFiles = false;
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapPageRoute("Robots", "robots.txt", "~/Lemoon/Robots.aspx");
            routes.MapPageRoute("Sitemap", "sitemap.xml", "~/Lemoon/Sitemap.aspx");
            routes.AddLemoonRoutes();
        }

        public override string GetVaryByCustomString(HttpContext context, string custom)
        {
            if (custom == "site")
            {
                // vary by site/language
                return MindrouteContext.Current.Site.LanguageID.ToString();
            }
            else if (custom == Lemoon.Plugins.OutputCachePlugin.CacheKey)
            {
                // vary by cache dependency from cache plugin
                return Lemoon.Plugins.OutputCachePlugin.GetVaryByCustomString();
            }
            return base.GetVaryByCustomString(context, custom);
        }
    }
}