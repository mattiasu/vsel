using Mindroute.Core.Model;
using Mindroute.Lemoon.Web.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace vsel.Lemoon.Templates
{
    public partial class StartPage : PageBase<ContentTypes.HomeType>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }
    }
}