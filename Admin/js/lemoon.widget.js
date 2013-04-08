var LemoonWidget = {

    jQuery: $,

    init: function (id) {
        this.id = id;
        this.handle = $(".widget[id=" + id + "]");

        this.getString = function (key) {
            var field = $(":input[id=" + key + "]", this.handle);
            if (field.length > 0) {
                return field.val();
            }
            return null;
        };

        this.getBool = function (key) {
            var field = $("input[type=checkbox][id=" + key + "]", this.handle);
            if (field != null) {
                return $(field).attr("checked");
            }
            return false;
        };

        this.getInt = function (key) {
            var field = $(":input[id=" + key + "]", this.handle);
            if (field != null) {
                return parseInt(field.val());
            }
            return null;
        };

        this.set = function (key, val) {
            $(":input[id=" + key + "]").val(val);

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: Lemoon.AdminUrl() + "api/widget/SaveSettings?id=" + id + "&" + key + "=" + val,
                dataType: "json",
                cache: false,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                },
                success: function (data, textStatus) {
                    if (data.Status == "error") {
                        alert(data.Message);
                    }
                }
            });
        };

        this.baseUrl = function () {
            return Lemoon.RootUrl();
        };

        this.setTitle = function (shortTitle, title) {
            $(".widget-head > h3", this.handle).text(shortTitle).attr("title", title);
        };

        this.startLoading = function (sender) {
            var area = $(".widget-content", this.handle);
            var height = area.outerHeight() < 40 ? 80 : area.outerHeight();
            area.height(height);
            area.addClass("loading");
        };

        this.endLoading = function (sender) {
            var area = $(".widget-content", this.handle);
            area.removeClass("loading");
            area.css("height", "");
        };
    }
};
