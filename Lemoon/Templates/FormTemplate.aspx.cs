using System;
using vsel.Lemoon.WebControls;
using Mindroute.Lemoon.Modules.FormModule;
using Mindroute.Lemoon.Web.UI;

namespace vsel.Lemoon.Templates
{
    public partial class FormTemplate : PageBase<FormHolder>
    {

        protected void form_OnLoad(Object sender, FormLoadEventArgs e)
        {
            // use code like below if you want to pre-populate the fields of your form
            //e.FormResult["MyFieldName"] = "My value";
        }

        protected void form_OnSave(Object sender, FormEventArgs e)
        {
            // save the form result
            form.SaveForm(e.FormResult);

            // send notification email
            form.SendMail(e.MailBody);

            // redirect to result page
            form.Redirect();
        }
    }
}
