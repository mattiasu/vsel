using Mindroute.Core.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace vsel.Lemoon.ContentTypes
{
    [Serializable]
    [Render(Name = "About us page", Description = "About page with map.")]
    [DefaultValues("IsSearchable", true, "DisplayInMenu", DisplayInMenu.Always, "IsEnabled", true, "Template", "~/Lemoon/Templates/AboutUs.aspx", "AllowedChildren", new string[] { "Mindroute.Core.Model.Content" })]
    public class AboutType : Content
    {
        /// <summary>
        /// Gets or sets the body text of the page.
        /// </summary>
        [Persisted]
        [DataType(DataType.Html)]
        public string Body { get; set; }

        /// <summary>
        /// Gets or sets the Right column title.
        /// </summary>
        [Persisted]
        public string RightColTitle { get; set; }

        /// <summary>
        /// Gets or sets the address displayed in the right column.
        /// </summary>
        [Persisted]
        [DataType(DataType.MultilineText)]
        [Layout(Height = "100px")]
        public string Address { get; set; }

        /// <summary>
        /// Gets or sets the API key used for the Map.
        /// </summary>
        [Persisted]
        public string GoogleMapsApiKey { get; set; }


    }
}