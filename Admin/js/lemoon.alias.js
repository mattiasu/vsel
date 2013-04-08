var LemoonAlias = {
  /* ------------------------------------------------------------   
  - Initializes main functionallity.
  ------------------------------------------------------------ */
  init: function() {
  },

  /* ------------------------------------------------------------   
  - Adds a row to the table.
  ------------------------------------------------------------ */
  Add: function() {
    var tr = $('<tr />');

    var td = $('<td />');

    
    var input = $('<select />');
    input.attr('name', 'alias_code');
    input.append($("<option />").attr("value", "200").text("200 OK"));
    input.append($("<option />").attr("value", "301").text("301 Moved"));
    input.append($("<option />").attr("value", "302").text("302 Found"));
    td.append(input);
    tr.append(td);

    td = $('<td />');
    input = $('<input />');
    input.attr('type', 'text');
    input.attr('name', 'alias_route');
    input.attr('value', '');
    td.append(input);
    tr.append(td);

    td = $('<td />');
    td.addClass('actions');
    td.append($('<a href="javascript:void(0);"><span class="icon-12 delete" onclick="LemoonAlias.Remove(this);"></span></a>'));
    tr.append(td);

    $('#alias tbody').append(tr);
  },
  Remove: function(sender) {
    $(sender).parents('tr').remove();
  }
};

$(document).ready(function() {
  LemoonAlias.init();
});


var LemoonBinding = {
  /* ------------------------------------------------------------   
  - Initializes main functionallity.
  ------------------------------------------------------------ */
  init: function () {
  },

  /* ------------------------------------------------------------   
  - Adds a row to the table.
  ------------------------------------------------------------ */
  Add: function () {
    var tr = $('<tr />');

    var td = $('<td />');
    var input = $('<input />');
    input.attr('type', 'text');
    input.attr('name', 'binding_host');
    input.attr('value', '');
    td.append(input);
    tr.append(td);

    td = $('<td />');
    input = $('<input />');
    input.attr('type', 'text');
    input.attr('name', 'binding_vdir');
    input.attr('value', '');
    td.append(input);
    tr.append(td);

    td = $('<td />');
    td.addClass('actions');
    td.append($('<a href="javascript:void(0);"><span class="icon-12 delete" onclick="LemoonBinding.Remove(this);"></span></a>'));
    tr.append(td);

    $('#bindings tbody').append(tr);
  },
  Remove: function (sender) {
    $(sender).parents('tr').remove();
  }
};

$(document).ready(function () {
  LemoonBinding.init();
});
