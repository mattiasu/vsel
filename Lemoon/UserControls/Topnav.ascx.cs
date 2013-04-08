using System;
using System.Collections.Generic;
using System.Linq;
using vsel.Lemoon.ContentTypes;
using Mindroute.Core.Model;
using Mindroute.Lemoon.Modules.CoreModule;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon.UserControls
{
    public partial class Topnav : UserControlBase
    {

        protected Content Start { get; set; }
        protected Content Search { get; set; }

        protected IEnumerable<Content> TopItems { get; set; }
        protected IEnumerable<Content> SubItems { get; set; }

        /// <summary>
        /// Slit topnav and subnav on this menu item.
        /// </summary>
        public int? SplitAt { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            Start = ContentService.Get("/");

            var children = ContentService.GetDescendants(Start.ID, depth: 1, displayInMenu: DisplayInMenu.Public);
            TopItems = SplitAt.HasValue ? children.Take(SplitAt.Value) : children;
            SubItems = SplitAt.HasValue ? children.Skip(SplitAt.Value) : null;


            Search = ContentService.Get("search");
        }
    }
}