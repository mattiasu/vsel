using Mindroute.Lemoon.Web.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using vsel.Lemoon.ContentTypes;

namespace vsel.Lemoon.UserControls
{
    public partial class Footer : UserControlBase
    {
        protected HomeType Start { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            Start = ContentService.Get<HomeType>("/");
        }
    }
}