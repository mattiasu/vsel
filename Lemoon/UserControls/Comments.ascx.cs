using System;
using System.Linq;
using System.Web.UI;
using Mindroute.Core.Model;
using Mindroute.Lemoon.Helpers;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon.UserControls
{

    public partial class Comments : UserControlBase<Content>
    {


        /// <summary>
        /// Gets or sets a value indicating whether the comment form should have a captcha to prevent spam. Default is true.
        /// </summary>
        public bool Captcha { get; set; }

        /// <summary>
        /// Gets or sets a title.
        /// </summary>
        public string Title { get; set; }

        public Comments()
        {
            Captcha = true;
        }


        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Visible = Content.Commenting != Commenting.Disabled;
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);



            if (Captcha)
            {
                Session["_captcha"] = true;
                chal.Value = new string(Session.SessionID.Reverse().ToArray());
                scri.Text = @"<script type=""text/javascript"">function setResp() { var str1 = document.getElementById('" + chal.ClientID + "').value; var str2 = ''; for (i = str1.length; i >= 0; i--) { str2 += str1.substring(i, i - 1); } document.getElementById('" + resp.ClientID + "').value = str2; }</script>";
                submit.OnClientClick = "setResp();";
            }
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // try to filter spammers
                if (Captcha && (Session["_captcha"] == null || Session.SessionID != resp.Value))
                {
                    text.ValidationError = Resources.Strings.CommentCaptchaError;
                    return;
                }

                // insert
                var comment = new Comment()
                {
                    ContentID = Content.ID,
                    LanguageID = Content.LanguageID,
                    Body = text.Value,
                    Email = email.Value,
                    Name = name.Value,
                    Url = url.Value
                };
                CommentService.Insert(comment);
                Response.Redirect(Content.Url());

            }
            else
            {
                // TODO: set focus on comment form            
            }
        }
    }
}