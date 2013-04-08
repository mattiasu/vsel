using System;
using Mindroute.Core.Collections;
using Mindroute.Core.Helpers;
using Mindroute.Core.Model;
using Mindroute.Lemoon.Helpers;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon.UserControls
{
    public partial class Pager : UserControlBase
    {

        /// <summary>
        /// Gets or sets the paged list for which to render a pager.
        /// </summary>
        public PagedList<Content> Result { get; set; }

        protected string PrevUrl { get; set; }
        protected string NextUrl { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            int p;
            if (!int.TryParse(Request["p"], out p))
            {
                p = 1;
            }

            PrevUrl = Content.Url() + "?" + Request.QueryString.Rebuild("p", p - 1).AsQueryString();
            NextUrl = Content.Url() + "?" + Request.QueryString.Rebuild("p", p + 1).AsQueryString();

        }
    }
}