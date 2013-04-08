using Mindroute.Core.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace vsel.Lemoon.ContentTypes
{
    [Serializable]
    [Render(Name = "Case page", Description = "Presenting a case page.")]
    [DefaultValues("IsSearchable", true, "DisplayInMenu", DisplayInMenu.Always, "IsEnabled", true, "Template", "~/Lemoon/Templates/Case.aspx", "AllowedChildren", new string[] { "Mindroute.Core.Model.Content" })]
    public class CaseType : Content
    {
        [Persisted]
        [Render(Weight = 10, Name="First Body")]
        [DataType(DataType.Html)]
        public string Body { get; set; }

        [Persisted]
        [Render(Weight = 20, Name = "Qoute image")]
        [DataType("File")]
        public ContentRef QuoteImage{get;set;}

        [Persisted]
        [Render(Weight = 30, Name = "Quote text")]
        [DataType(DataType.MultilineText)]
        public string QuoteText { get; set; }

        [Persisted]
        [Render(Weight=35, Name="Secondary title")]
        public string SecondaryTitle{ get; set; }

        [Persisted]
        [Render(Weight = 40, Name = "Secondary Body")]
        [DataType(DataType.Html)]
        public string SecondaryBody { get; set; }

        [Persisted]
        [Render(Weight = 50, Name = "Secondary image")]
        [DataType("File")]
        public ContentRef SecondaryImage{get;set;}


    }
}