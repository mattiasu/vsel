/// <reference path="jquery-1.4.2.js"/>

var LemoonFieldset = {
  /* ------------------------------------------------------------   
  - Initializes main functionallity.
  ------------------------------------------------------------ */
  init: function() {
  },

  /* ------------------------------------------------------------   
  - Hides all tabs and displays the selected one.
  - tabID: ClientID of the fieldset to select.
  - sender: Referense to the clicked anchor.
  ------------------------------------------------------------ */
  ShowTab: function(tabid, sender) {
    $('.tab').hide();
    $('#' + tabid).show();
    $('.tabs').find("li").each(function(i) {
      if ($(this).hasClass('validationerror')) {
        $(this).attr('class', 'validationerror');
      }
      else {
        $(this).attr('class', '');
      }
    });    
    $(sender).parent().addClass('selected');
  }
};

$(document).ready(function() {
    LemoonFieldset.init();
});
