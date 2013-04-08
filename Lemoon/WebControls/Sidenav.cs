using System;
using System.Linq;
using System.Collections.Generic;
using System.Web.UI;
using Mindroute.Core.Helpers;
using Mindroute.Core.Model;
using Mindroute.Lemoon.Helpers;
using Mindroute.Lemoon.Modules.CoreModule;
using Mindroute.Lemoon.Web.UI.WebControls;

namespace vsel.Lemoon.WebControls
{

    /// <summary>
    /// Control that renders a submenu. 
    /// </summary>
    public class Sidenav : WebControlBase
    {

        Content _root = null;
        IList<Content> _children = null;

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            _root = Content.TopContent();
            if (_root != null)
            {
                _children = ContentService.GetDescendants(_root.ID, depth: 1, displayInMenu: DisplayInMenu.Public);
            }

            Visible = !_children.IsNullOrEmpty();
        }

        protected override void Render(HtmlTextWriter writer)
        {
            writer.WriteBeginTag("div");
            writer.WriteAttribute("class", "well");
            writer.WriteLine(HtmlTextWriter.TagRightChar);

            writer.WriteBeginTag("ul");
            writer.WriteAttribute("class", "nav nav-list");
            writer.WriteLine(HtmlTextWriter.TagRightChar);

            writer.WriteLine(@"<li class=""nav-header"">" + _root.MenuTitle().HtmlSafe() + "</li>");

            if (!_children.IsNullOrEmpty())
            {
                foreach (var child in _children)
                {
                    RenderItem(child, writer);
                }
            }
            writer.WriteEndTag("div");
            writer.WriteLine();
        }

        private void RenderItem(Content item, HtmlTextWriter writer)
        {
            writer.WriteBeginTag("li");
            if (item.ID == Content.ID)
            {
                writer.WriteAttribute("class", "active");
            }
            writer.Write(HtmlTextWriter.TagRightChar);

            writer.WriteBeginTag("a");
            if (item is Link && ((Link)item).OpenNewWindow)
            {
                writer.WriteAttribute("target", "_blank");
            }
            writer.WriteAttribute("href", item.Url());
            writer.Write(HtmlTextWriter.TagRightChar);
            writer.Write(item.MenuTitle().HtmlSafe());
            writer.WriteEndTag("a");

            if (item.IsSelected())
            {
                var children = ContentService.GetDescendants(item.ID, depth: 1, displayInMenu: DisplayInMenu.Public);
                if (!children.IsNullOrEmpty())
                {
                    writer.WriteBeginTag("ul");
                    writer.WriteAttribute("class", "nav nav-list");
                    writer.WriteLine(HtmlTextWriter.TagRightChar);
                    writer.WriteLine();
                    foreach (var child in children)
                    {
                        RenderItem(child, writer);
                    }
                    writer.WriteEndTag("ul");
                }
            }
            writer.WriteEndTag("li");
            writer.WriteLine();
        }
    }

}