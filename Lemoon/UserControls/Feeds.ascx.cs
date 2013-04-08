using System;
using Mindroute.Core.Helpers;
using Mindroute.Lemoon.Helpers;
using Mindroute.Lemoon.Modules.CoreModule;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon.UserControls
{
    public partial class Feeds : UserControlBase
    {

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            Visible = Content != null && !Content.Feeds().IsNullOrEmpty();
        }

        protected string GetTitle(FeedType type)
        {
            var title = Content.FeedTitle();
            if (type != FeedType.Creates)
            {
                title += " (" + Resources.Strings.ResourceManager.GetString("FeedType_" + type) + ")";
            }
            return title;
        }
    }
}