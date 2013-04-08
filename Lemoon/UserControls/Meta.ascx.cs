using System;
using Mindroute.Core.Helpers;
using Mindroute.Core.Model;
using Mindroute.Lemoon.Helpers;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon.UserControls
{
    public partial class Meta : UserControlBase
    {

        public string MetaKeywords { get; set; }
        public string MetaDescription { get; set; }
        public string MetaRobots { get; set; }
        public string MetaSiteVerification { get; set; }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            if (Content != null)
            {
                MetaDescription = (Content.MetaDescription() ?? Content.Teaser ?? Site.MetaDescription()).RemoveDuplicateWhiteSpace();
                MetaKeywords = (Content.MetaKeywords() ?? TagService.ToTagString(Content.Tags) ?? Site.MetaKeywords()).RemoveDuplicateWhiteSpace();
                MetaRobots = Content.MetaRobots();
            }
            else
            {
                MetaDescription = Site.MetaDescription().RemoveDuplicateWhiteSpace();
                MetaKeywords = Site.MetaKeywords().RemoveDuplicateWhiteSpace();
            }
            MetaSiteVerification = Site.MetaSiteVerification();
        }

    }
}