using Mindroute.Core.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.SessionState;
using vsel.Lemoon.ContentTypes;

namespace vsel.assets.Handlers
{

    public class MessageCarrier
    {
        public int Id { get; set; }
        public string Sender { get; set; }
        public string Message { get; set; }
        public string Phone { get; set; }
    }

    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class ContactHandler : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                var message = new MessageCarrier()
                {
                    Id = 0,
                    Sender = context.Request.Params["sender"] ?? context.Request["sender"],
                    Message = context.Request.Params["message"] ?? context.Request["message"],
                    Phone = context.Request.Params["phone"] ?? context.Request["phone"]
                };

                if (!string.IsNullOrEmpty(message.Message) && !string.IsNullOrEmpty(message.Sender))
                {
                    ContentService contentService = ServiceLocator.Get<ContentService>();
                    HomeType startPage = contentService.Get<HomeType>("/", null, true);

                    if (startPage != null)
                    {
                        startPage.Comments.Add(new Mindroute.Core.Model.Comment()
                        {
                            Created = DateTime.Now,
                            Email = message.Sender,
                            Body = MakeMessage(message)
                        });
                    }
                }
            }
            catch(Exception e)
            {
                context.Response.StatusCode = 500;
                context.Response.StatusDescription = "Internal Server Error";
                context.Response.ContentType = "application/json";
                context.Response.End();
            }
           
            
            
        }

        private string MakeMessage(MessageCarrier carrier)
        {
             return string.Format("E-post: {0} <br/>Telefon: {1}<br/>Meddelande:<br/>", carrier.Sender, carrier.Phone, carrier.Message);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}