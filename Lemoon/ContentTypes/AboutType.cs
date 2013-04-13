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
        [Render(Weight=10, Name="Body", Description="Main body of page")]
        public string Body { get; set; }

        /// <summary>
        /// Gets or sets the Right column title.
        /// </summary>
        [Persisted]
        [Render(Weight=20, Name="Right column title", Description="The title of the rigth column")]
        public string RightColTitle { get; set; }

        /// <summary>
        /// Gets or sets the address displayed in the right column.
        /// </summary>
        [Persisted]
        [DataType(DataType.MultilineText)]
        [Render(Weight=30, Name="Address info")]
        [Layout(Height = "100px")]
        public string Address { get; set; }

        [Persisted]
        [Render(Weight=40, Name="About us Image", Description="Image of all employees")]
        public ContentRef AboutImage{ get; set; }
        

    }
}