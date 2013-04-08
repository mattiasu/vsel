var allow = "icon-12 allow";
var deny = "icon-12 deny";
var na = "icon-12 none";
var iconBase = "icon-12";

function ReplaceCheckboxes() {
  var i = $("#permissions :checkbox:hidden").length;

  // replace the checkboxes with images
  $("#permissions :checkbox:visible").hide().each(function () {
    var span = document.createElement('span');
    var className = "";
    var title;
    switch ($(this).val()) {
      case "0":
        className = na;
        title = LemoonResources.None;
        $(this).attr("checked", "false");
        break;
      case "1":
        className = allow;
        title = LemoonResources.Allow;
        $(this).attr("checked", "true");
        break;
      case "2":
        className = deny;
        title = LemoonResources.Deny;
        $(this).attr("checked", "true");
    }
    // set id to track image type
    $(this).attr("id", "input" + i + "image" + i);
    $(span).attr("id", "" + i + "image" + i);
    $(span).addClass(className);
    $(span).attr("title", title);
    i++;
    $(this).before(span);
  });
}

$(document).ready(function () {

  ReplaceCheckboxes();

  // add click handler
  $(".icon-12").live("click", function () {

    // select the checkbox corresponding to the clicked img
    t = $("#input" + $(this).attr("id"));

    switch (t.val()) {
      case "0":
        $(this).attr("class", allow);
        $(this).attr("title", LemoonResources.Allow);
        t.val(1).attr("checked", "true");
        break;
      case "1":
        $(this).attr("class", deny);
        $(this).attr("title", LemoonResources.Deny);
        t.val(2).attr("checked", "true");
        break;
      case "2":
        $(this).attr("class", na);
        $(this).attr("title", LemoonResources.None);
        t.val(0).removeAttr("checked");
    }
  });
  // add click hander for remove
  $(".delentity").live("click", function () {
    $(this).parent().parent().remove();
  });
});


function AddPermissionRow(id, type, title) {
  var oldEntries = $("#permissions input[type=hidden]");
  var found = false;
  for (var ii = 0; ii < oldEntries.length; ii++) {
    if (id + ':' + type + ':' + title == $(oldEntries).eq(ii).val()) {
      found = true;
    }
  }
  if (!found) {
    var masks = ["Read", "Create", "Edit", "Delete", "Admin"]
    var row = $("<tr />");
    var entity = $("<td />");
    entity.append($("<span />").addClass(iconBase).addClass(type));
    entity.append(title);
    var hidden = $("<input />").attr("type", "hidden").attr("name", "entity").val(id + ':' + type + ':' + title);
    entity.append(hidden);
    row.append(entity);
    var read = "0";
    for (var i = 0; i < masks.length; i++) {
      read = "0";
      if (i == 0) {
        read = "1";
      }
      row.append($("<td />").append($("<input />").attr("type", "checkbox").attr("name", id + ':' + type + ':' + title + ":" + masks[i]).val(read)));
    }
    row.append($("<td />").append($("<a />").attr("href", "#").addClass("delentity").append($("<span />").addClass(iconBase).addClass("delete"))));
    $("#permissions tbody").append(row);
    ReplaceCheckboxes();
  }
}  

