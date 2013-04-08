using System;
using Mindroute.Core.Helpers;
using Mindroute.Core.Model;
using Mindroute.Lemoon.Helpers;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon.UserControls
{

    public partial class Analytics : UserControlBase
    {

        public string AnalyticsID { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            AnalyticsID = AnalyticsID ?? Site.AnalyticsID();
            Visible = !AnalyticsID.IsNullOrEmpty();
        }
    }
}