using System;
using System.Collections.Generic;
using System.Linq;
using Mindroute.Core.Model;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon.UserControls
{
    public partial class Tagcloud : UserControlBase
    {

        public int? ParentID { get; set; }

        protected IEnumerable<Tag> Tags { get; set; }

        protected Content Root { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            Root = ParentID.HasValue ? ContentService.Get(ParentID.Value) : Content;

            if (Root != null)
            {
                Tags = TagService.GetTopTags(Root.ID, 50).OrderBy(x => x.Name);
            }

            Visible = Tags != null && Tags.Any();
        }
    }
}