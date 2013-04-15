<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="vsel.Lemoon.UserControls.Footer" %>
  <!-- Call to Action Panel -->
<footer>  
<div class="row footerstart">
    <div class="twelve columns">
    
      <div class="panel">
        <h4><%= Start.ContactTitle %></h4>
            
        <div class="row">
          <div class="nine columns">
            <%= Start.ContactText.HtmlSafe(true) %>
          </div>
          <div class="three columns">
            <a id="contactBtn" class="radius button right">Kontakta oss</a>
          </div>
        </div>
         <div class="row" id="forms">
              <hr />
             <div class="four columns">
                 <input type="text" id="email" name="e-post" title="e-post" tabindex="1" placeholder="E-post" />
                 <input type="text" id="phone" name="namn" title="telefon" tabindex="2" placeholder="Telefon" />
             </div>
             <div class="eight columns">
                 <textarea tabindex="3" name="meddelande" id="message" title="meddelande" placeholder="Meddelande" ></textarea>
                 <img id="loader" class="right" src="/assets/images/al.gif" alt="" />
                 <a id="sendBtn" class="radius button right">Skicka</a>
             </div>
         </div>
          <div class="row" id="ok">
              <hr />
              <div class="twelve columns"></div>
          </div>
      </div>
      
    </div>
  </div>
    <hr />
    <div class="row mid">
        <div class="six columns">
            <span>&copy; <%= Content.Site.MetaData.Get<string>("Copyright") %></span>
        </div>
        <div class="six columns right">
            <ul class="bare right">
                    <li><span>Följ oss på: </span>   </li>
                   <li><a id="fb" target="_blank" href="<%= Content.Site.MetaData.Get<string>("fb-link") %>"></a></li>
                   <li><a id="twitter" target="_blank" href="<%= Content.Site.MetaData.Get<string>("twitter-link") %>"></a></li>
               </ul>
      </div> 
        </div>
    <hr />
    <div class="row center">
            <a id="link-top" class="right" href="#">tillbaka till toppen</a>
    </div>
  </footer>