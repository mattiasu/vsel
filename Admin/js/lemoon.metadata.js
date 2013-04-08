var LemoonMetadata = {
  /* ------------------------------------------------------------   
  - Initializes main functionallity.
  ------------------------------------------------------------ */
  init: function () {
  },

  /* ------------------------------------------------------------   
  - Adds a row to the meta data table.
  ------------------------------------------------------------ */
  AddMetaData: function (containerID) {
    if (containerID == null) {
      containerID = 'metadata';
    }

    var tr = $('<tr />');

    var td = $('<td />');
    tr.append(td);

    var input = $('<input />');
    input.attr('type', 'text');
    input.attr('name', 'mkey' + containerID);
    input.attr('value', '');
    td.append(input);

    td = $('<td />');
    tr.append(td);

    input = $('<select />');
    input.attr('name', 'mtyp' + containerID);
    input.append($("<option />").attr("value", "string").text("String"));
    input.append($("<option />").attr("value", "integer").text("Integer"));
    input.append($("<option />").attr("value", "double").text("Double"));
    input.append($("<option />").attr("value", "bool").text("Bool"));
    td.append(input);

    td = $('<td />');
    tr.append(td);

    input = $('<input />');
    input.attr('type', 'text');
    input.attr('name', 'mval' + containerID);
    input.attr('value', '');
    td.append(input);

    td = $('<td />');
    td.addClass('actions');
    td.append($('<a href="javascript:void(0);"><span class="icon-12 delete" onclick="LemoonMetadata.Remove(this);"></span></a>'));
    tr.append(td);

    $('#' + containerID).append(tr);
  },
  Remove: function (sender) {
    $(sender).parents('tr').remove();
  }
};

$(document).ready(function() {
  LemoonMetadata.init();
});
