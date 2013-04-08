using Mindroute.Lemoon.Web.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vsel.Lemoon.Templates
{
    public partial class AboutUs : PageBase<ContentTypes.AboutType>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var masterPage = Master;
            if (masterPage != null)
            {
                var siteMaster = (masterPage as vsel.Lemoon.MasterPages.Vsel);
                if (siteMaster != null)
                {
                    siteMaster.HideFooter();
                }
            }
        }
    }
}