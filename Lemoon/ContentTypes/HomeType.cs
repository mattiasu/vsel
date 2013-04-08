using Mindroute.Core.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace vsel.Lemoon.ContentTypes
{
    [Serializable]
    [Render(Name = "Start page", Description = "Start page for VSEL.")]
    [DefaultValues("IsSearchable", true, "DisplayInMenu", DisplayInMenu.Always, "IsEnabled", true, "Template", "~/Lemoon/Templates/StartPage.aspx", "AllowedChildren", new string[] { "Mindroute.Core.Model.Content" })]
    public class HomeType : Content
    {

        [Persisted]
        [Render(Weight=10, Name="Slider images")]
        [DataType("Files")]
        public List<ContentRef> SliderImages {
            get;
            set;
        }

        [Persisted]
        [Render(Weight = 20, Name = "Column images")]
        [DataType("Files")]
        public List<ContentRef> ColImages
        {
            get;
            set;
        }

        [Persisted]
        [Render(Weight = 50, Name = "Column Pages")]
        [DataType("Pages")]
        public List<ContentRef> ColPages
        {
            get;
            set;
        }

        [Persisted]
        [Render(Weight=60, Name="Contact title", Description="Title of the contact area")]
        public string ContactTitle { get; set; }

        [Persisted]
        [Render(Weight = 65, Name = "Contact information")]
        [DataType(DataType.MultilineText)]
        public string ContactText{get;set;}

        [Persisted]
        [Render(Weight = 65, Name = "Contact information")]
        [DataType(DataType.MultilineText)]
        public string ContactTextResponse{get;set;}




    }
}