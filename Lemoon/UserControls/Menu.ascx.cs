using Mindroute.Lemoon.Web.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model = Mindroute.Core.Model;
using Mindroute.Core.Helpers;
using Mindroute.Core.Services;
using Mindroute.Lemoon.Modules.CoreModule;
using Mindroute.Core.Model;


namespace vsel.Lemoon.UserControls
{
    public partial class Menu : UserControlBase
    {
        protected Mindroute.Core.Model.Content Start { get; set; }
        
        protected IEnumerable<Mindroute.Core.Model.Content> TopItems { get; set; }

        /// <summary>
        /// Slit topnav and subnav on this menu item.
        /// </summary>
        public int? SplitAt { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            Start = ContentService.Get("/");
            TopItems = ContentService.GetDescendants(Start.ID, depth: 1, displayInMenu: DisplayInMenu.Public);



        }
    }
}