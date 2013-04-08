using System;
using System.Globalization;
using System.Threading;
using Mindroute.Core.Model;
using Mindroute.Core.Search;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon.UserControls
{
    public partial class Archive : UserControlBase
    {

        public int? ParentID { get; set; }

        protected ArchiveList List { get; set; }

        protected DateTimeFormatInfo DateInfo { get; set; }

        protected Content Root { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            Root = ParentID.HasValue ? ContentService.Get(ParentID.Value) : Content;

            if (Root != null)
            {
                ContentQuery query = new ContentQuery() { ParentID = Root.ID, MinDepth = 1, MaxDepth = 1, SearchNonSearchable = null };
                DateInfo = DateTimeFormatInfo.GetInstance(Thread.CurrentThread.CurrentUICulture);
                List = ContentService.GetArchive(query);
            }

            Visible = List != null && List.GetCount() > 0;
        }
    }
}