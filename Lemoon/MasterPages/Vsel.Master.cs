using Mindroute.Lemoon.Web.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vsel.Lemoon.MasterPages
{
    public partial class Vsel : MasterPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void HideFooter()
        {
            if (footerControl != null)
                footerControl.Visible = false;
            else
            {
                var cachedFooter = (PartialCachingControl)LoadControl(@"\Lemoon\UserControls\Footer.ascx");
                Page.Controls.Add(cachedFooter);
                if (cachedFooter.CachedControl != null)
                {
                    var footer = cachedFooter.CachedControl as vsel.Lemoon.UserControls.Footer;
                    if (footer != null) footer.Visible = false;
                }
            }
        }
    }
}