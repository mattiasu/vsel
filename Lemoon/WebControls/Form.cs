using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using Mindroute.Core.Helpers;
using Mindroute.Core.Model;
using Mindroute.Core.Services;
using Mindroute.Lemoon.Helpers;
using Mindroute.Lemoon.Modules.CoreModule;
using Mindroute.Lemoon.Modules.FormModule;
using Mindroute.Lemoon.Web.UI.Admin.WebControls;
using Mindroute.Lemoon.Web.UI.WebControls;
using NLog;

namespace vsel.Lemoon.WebControls
{

    /// <summary>
    /// Control that renders a form.
    /// </summary>
    public class Form : WebControlBase
    {

        private static readonly Logger _log = LogManager.GetCurrentClassLogger();

        private FormHolder _form;
        private FormContent _result;
        private HtmlInputHidden chal;
        private HtmlInputHidden resp;
        private string _validationGroup = string.Empty;
        private System.Web.UI.WebControls.Button _saveButton;

        /// <summary>
        /// Save form event handler.
        /// </summary>
        public event SaveFormHandler SaveFormEvent;

        /// <summary>
        /// Load form event handler.
        /// </summary>
        public event LoadFormHandler LoadFormEvent;

        /// <summary>
        /// Delegate used for the OnSaveForm event.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public delegate void SaveFormHandler(object sender, FormEventArgs e);

        /// <summary>
        /// Delegate used for the OnLoadForm event.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public delegate void LoadFormHandler(object sender, FormLoadEventArgs e);

        /// <summary>
        /// Event fired when the form is saved.
        /// </summary>
        /// <param name="e">Form event arguments.</param>
        protected virtual void OnSaveForm(FormEventArgs e)
        {
            SaveFormEvent(this, e);
        }

        /// <summary>
        /// Event fired when the form is loaded.
        /// </summary>
        /// <param name="e">Form event arguments.</param>
        protected virtual void OnLoadForm(FormLoadEventArgs e)
        {
            try
            {
                LoadFormEvent(this, e);
            }
            catch
            {
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether posts should be rejected if they appear to be spam, default is <c>true</c>.
        /// </summary>
        public bool EnableCaptcha { get; set; }

        /// <summary>
        /// Gets or sets a the Content ID of the Form to render, <c>null</c> assumes that you want to render the current content item.
        /// </summary>
        public int? ContentID { get; set; }

        /// <summary>
        /// Renders the form.
        /// </summary>
        /// <param name="output"></param>
        protected override void Render(HtmlTextWriter output)
        {
            if (_result != null)
            {
                if (HasControls())
                {
                    output.Write(@"<ul class=""form " + (string.IsNullOrEmpty(_result.LabelAlignment) ? "topLabel" : _result.LabelAlignment) + @""">");
                    foreach (Control c in Controls)
                    {
                        c.RenderControl(output);
                    }
                    output.Write(@"</ul>");
                }
            }
            else
            {
                output.Write(@"Form ""{0}"" not found.", _form.FormContentID);
            }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            _form = ContentID.HasValue ? ContentService.Get<FormHolder>(ContentID.Value) : Content as FormHolder;
            if (_form == null)
            {
                HttpContext.Current.Response.Write("Form not found.");
                HttpContext.Current.Response.End();
            }

            _validationGroup = _form.ValidationGroup;

            _result = ServiceLocator.Get<Content>(_form.FormContentID) as FormContent;
            if (_result != null)
            {

                // Fires the OnLoadForm event.
                OnLoadForm(new FormLoadEventArgs(_result));

                // get all fields with ShowForEdit
                List<PersistedField> fields = _result.GetPersistedFields().Where(x => x.ShowForDisplay).ToList();

                // create form controls and add them to the ul tag.
                var controls = FormHelper.CreateFormControls(fields, "form", !Page.IsPostBack);

                foreach (var ctrl in controls)
                {
                    ctrl.ValidationGroup = _validationGroup;
                    this.Controls.Add((Control)ctrl);
                    if (Page.IsPostBack)
                    {
                        FormHelper.SetFormValue(ctrl);
                    }
                }

                // Adds the captcha and save button
                HtmlGenericControl li = new HtmlGenericControl("li");
                _saveButton = new System.Web.UI.WebControls.Button();
                _saveButton.Text = _form.SubmitLabel ?? Mindroute.Lemoon.Properties.Resources.Save;
                _saveButton.CssClass = "btn btn-primary";
                _saveButton.ValidationGroup = _validationGroup;
                _saveButton.Click += new EventHandler(save_Click);
                li.Controls.Add(_saveButton);
                chal = new HtmlInputHidden();
                li.Controls.Add(chal);
                resp = new HtmlInputHidden();
                li.Controls.Add(resp);
                this.Controls.Add(li);
            }
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (EnableCaptcha)
            {
                HttpContext.Current.Session["antispam"] = true;
                char[] arr = HttpContext.Current.Session.SessionID.ToCharArray();
                Array.Reverse(arr);
                chal.Value = new string(arr);
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "captcha_script" + this.ClientID, @"function setResp" + this.ClientID + @"() { var str1 = document.getElementById('" + chal.ClientID + "').value; var str2 = ''; for (i = str1.length; i >= 0; i--) { str2 += str1.substring(i, i - 1); } document.getElementById('" + resp.ClientID + "').value = str2; }", true);
                _saveButton.OnClientClick = "setResp" + this.ClientID + "();";
            }
        }

        protected void save_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            // check captcha
            if (EnableCaptcha && (HttpContext.Current.Session["antispam"] == null || HttpContext.Current.Session.SessionID != resp.Value))
            {
                return;
            }

            FormContent formContent = ServiceLocator.Get<Content>(_form.FormContentID) as FormContent;
            IFormField ctrl = null;
            var fields = formContent.GetPersistedFields();
            StringBuilder mailBody = new StringBuilder();
            foreach (PersistedField field in fields)
            {
                ctrl = this.FindControl(field.Name) as IFormField;
                if (ctrl != null && !(ctrl is HtmlField) && !(ctrl is LabelField))
                {
                    string fieldTitle;
                    if (!string.IsNullOrEmpty(field.ExportTitle))
                    {
                        fieldTitle = field.ExportTitle;
                    }
                    else
                    {
                        fieldTitle = string.IsNullOrEmpty(field.DisplayName) ? field.Name : field.DisplayName;
                    }
                    string returnValue = string.Empty;
                    if (ctrl is UploadField)
                    {
                        try
                        {
                            ContentRef defaultFolder = formContent.Site.MetaData.Get<ContentRef>("_lemoon_defaultuploadfolder");
                            if (defaultFolder != null && defaultFolder.Value != null)
                            {
                                HttpPostedFile uploadedFile = ((UploadField)ctrl).PostedFile;
                                string fileName = Path.GetFileName(uploadedFile.FileName);
                                Document document = ContentService.ResolveBinaryContent(FileHelper.GetExtension(fileName));
                                document.Title = fileName;
                                document.Stream = uploadedFile.InputStream;

                                Content parent = ContentService.Get(defaultFolder.Value.ID, defaultFolder.Value.LanguageID);
                                if (parent != null)
                                {
                                    document.LanguageID = parent.LanguageID;
                                    document.ParentID = parent.ID;
                                }

                                ContentService.Insert(document);
                                returnValue = document.Url(true);
                                field.Value = returnValue;
                                formContent.SetPersistedValue(field.Name, field.Value);
                            }
                        }
                        catch (Exception ex)
                        {
                            returnValue = ex.Message;
                        }
                    }
                    else
                    {
                        field.Value = ctrl.Value;

                        switch (field.Template)
                        {
                            case "SelectMany":
                            case "CheckBoxList":
                            case "CheckBoxes":
                                if (field.Value != null)
                                {
                                    // Get the text value of the options
                                    var selectValues = FormHelper.GetLocalizedOptions<string>(field);
                                    Mindroute.Lemoon.Web.UI.WebControls.ListItem<string> selectedItem = null;
                                    foreach (string item in field.Value as List<string>)
                                    {
                                        selectedItem = selectValues.SingleOrDefault(x => x.Value == item);
                                        if (selectedItem != null)
                                        {
                                            // Show text and value
                                            returnValue += string.Format("{0} ({1})\n", selectedItem.Text, item);
                                        }
                                        else
                                        {
                                            // Show value only
                                            returnValue += item + "\n";
                                        }
                                    }
                                }
                                break;

                            default:
                                if (field.Value != null)
                                {
                                    returnValue = field.Value.ToString();
                                }
                                else
                                {
                                    returnValue = string.Empty;
                                }
                                break;
                        }

                        formContent.SetPersistedValue(field.Name, field.Value);
                    }
                    mailBody.AppendFormat("{0}: {1}\n", fieldTitle, returnValue);
                }
            }

            formContent.ParentID = _form.ID;
            formContent.Title = string.Format("{0} - {1}", _form.Title, DateTime.UtcNow.ToLocal().ToString("yyyy-MM-dd HH:mm"));

            // Fires the OnSaveForm event.
            OnSaveForm(new FormEventArgs(formContent, mailBody.ToString()));
        }

        /// <summary>
        /// Saves the form result.
        /// </summary>
        /// <param name="formContent">Content to insert.</param>
        public void SaveForm(Content formContent)
        {
            // Hide form result posting.
            formContent.IsPublished = false;

            // Override permission check.
            ContentService.Insert(formContent, checkPermissions: false);
        }

        /// <summary>
        /// Sends the mail using the parameters specified in the FormHolder.
        /// </summary>
        /// <param name="body">A string that contains the message body.</param>
        public void SendMail(string body)
        {
            string from = _form.EmailSender;
            string to = _form.EmailReceiver;
            string subject = _form.EmailSubject;

            if (string.IsNullOrEmpty(from) || string.IsNullOrEmpty(to) || string.IsNullOrEmpty(subject))
            {
                _log.Info("Email notifications for {0} have not been configured.", _form.Url());
            }
            else
            {
                _log.Debug("Queueing notification mail: " + subject);
                MailMessage message = new MailMessage();
                try
                {
                    message.From = new MailAddress(from);
                }
                catch
                {
                    _log.Warn("Invalid sender {0} in notification email for {1}", from, _form.Url());
                    return;
                }
                if (to.Contains(","))
                {
                    // multiple recipients
                    var emails = to.Split(',');
                    foreach (var email in emails)
                    {
                        try
                        {
                            message.To.Add(new MailAddress(email.Trim()));
                        }
                        catch
                        {
                            _log.Warn("Invalid recipient {0} in notification email for {1}", email.Trim(), _form.Url());
                        }
                    }
                }
                else
                {
                    // single recipient
                    try
                    {
                        message.To.Add(new MailAddress(to));
                    }
                    catch
                    {
                        _log.Warn("Invalid recipient {0} in notification email for {1}", to, _form.Url());
                        return;
                    }
                }
                message.Subject = subject;
                message.Body = body;
                MailService.Queue(message);
            }
        }

        /// <summary>
        /// Redirects the page using the parameters specified in the FormHolder.
        /// </summary>
        public void Redirect()
        {
            var url = _form.Redirect.Url() ?? Content.Url();
            HttpContext.Current.Response.Redirect(url);
        }
    }

    /// <summary>
    /// Form event arguments
    /// </summary>
    public class FormEventArgs : EventArgs
    {

        /// <summary>
        /// Initializes the FormEventArgs class.
        /// </summary>
        /// <param name="formResult">The <see cref="Content"/> item that was populated by the form.</param>
        /// <param name="mailBody">The text of the notification mail.</param>
        public FormEventArgs(FormContent formResult, string mailBody)
        {
            FormResult = formResult;
            MailBody = mailBody;
        }

        /// <summary>
        /// Gets or sets the <see cref="Content"/> item that was populated by the form.
        /// </summary>
        public FormContent FormResult { get; set; }

        /// <summary>
        /// Gets or sets the text of the notification mail.
        /// </summary>
        public string MailBody { get; set; }
    }

    /// <summary>
    /// Form event arguments
    /// </summary>
    public class FormLoadEventArgs : EventArgs
    {

        /// <summary>
        /// Initializes the FormLoadEventArgs class.
        /// </summary>
        /// <param name="formResult">The <see cref="Content"/> item that will be populated by the form.</param>
        public FormLoadEventArgs(FormContent formResult)
        {
            this.FormResult = formResult;
        }

        /// <summary>
        /// The <see cref="Content"/> item that will be populated by the form.
        /// </summary>
        public Content FormResult { get; set; }
    }
}
