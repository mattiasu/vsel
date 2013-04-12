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

    //[WebService(Namespace = "http://tempuri.org/")]
    //[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class ContactHandler : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                var message = new MessageCarrier()
                {
                    Id = 0,
                    Sender = context.Request["sender"] ?? context.Request["sender"],
                    Message = context.Request["message"] ?? context.Request["message"],
                    Phone = context.Request["phone"] ?? context.Request["phone"]
                };

                if (!string.IsNullOrEmpty(message.Message) && !string.IsNullOrEmpty(message.Sender))
                {
                    ContentService contentService = ServiceLocator.Get<ContentService>();
                    CommentService commentService = ServiceLocator.Get<CommentService>();

                    HomeType startPage = contentService.Get<HomeType>("/", null, true);

                    if (startPage != null && commentService != null)
                    {
                        Mindroute.Core.Model.Comment comment = new Mindroute.Core.Model.Comment()
                        {
                            Title = message.Sender,
                            Url = message.Phone,
                            Body = message.Message,
                            Email = message.Sender,
                            Status = Mindroute.Core.Model.CommentStatus.Pending,
                            ContentID = startPage.ID,
                            Created = DateTime.Now,
                            LanguageID = startPage.LanguageID
                        };

                        commentService.Insert(comment);
                    }
                }

                context.Response.StatusCode = 200;
                context.Response.End();
            }
            catch(Exception e)
            {
                context.Response.StatusCode = 500;
                context.Response.StatusDescription = "Internal Server Error";
                context.Response.ContentType = "application/json";
                //context.Response.Write(string.Format("{error: {0}}", e.Message));
                context.Response.End();
            }
           
            
            
        }

        //private string MakeMessage(MessageCarrier carrier)
        //{
        //     return string.Format("E-post: {0} Telefon: {1} \\r Meddelande: {2}", carrier.Sender, carrier.Phone, carrier.Message);
        //}

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}