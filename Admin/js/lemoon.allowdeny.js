var allow = "icon-12 allow";
var deny = "icon-12 deny";
var na = "icon-12 none";

function AllowDenyReplaceCheckboxes() {
    var i = $(".allowdeny :checkbox:hidden").length;

    // replace the checkboxes with images
    $(".allowdeny :checkbox").hide().each(function() {
        var span = $("<span />");
        var className;
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
        i++;
        span.attr("class", className);
        span.attr("title", title);
        $(this).before(span);
    });
}

$(document).ready(function() {

    AllowDenyReplaceCheckboxes();

    // add click handler
    $(".icon-12").live("click", function() {
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
});