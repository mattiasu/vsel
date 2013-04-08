using System;
using Mindroute.Core.Model;

namespace vsel.Lemoon.ContentTypes
{

    [Serializable]
    [Render(Name = "Container", Description = "Used as a container for modules etc.")]
    [DefaultValues("IsRoutable", false, "IsSearchable", false, "DisplayInMenu", DisplayInMenu.Admin, "IsEnabled", true, "AllowedChildren", new string[] { "Mindroute.Core.Model.Content" })]
    public class Container : Content
    {

    }
}