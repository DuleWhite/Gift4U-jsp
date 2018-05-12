$(function() {
    // magicZoom
    $("#zoom-img").magicZoom();
    var currentSelectedImg = $(".guide-img")[0];
    $(".guide-img").click(function() {
        var oldPath = this.src,
            newPath = "";
        newPath += oldPath.replace(/-s/, "-l");
        $("#zoom-img").attr('src', newPath);
        $("#magiczoom-zoom").css('background-image', 'url(' + newPath + ')');
        $(currentSelectedImg).removeClass("selected");
        $(this).addClass("selected");
        currentSelectedImg = this;
    });

    var currentSelectedColor = null
    $(".color-label").click(function() {
        if (currentSelectedColor) {
            $(currentSelectedColor).removeClass("selected");
        }
        $(this).addClass("selected");
        currentSelectedColor = this;
    });

    document.getElementById("quantity-input").addEventListener("keypress", function(event) {
        if (event.keyCode == 45) {
            event.preventDefault();
        }
    });

    $("#quantity-input").val("1");

    var product_parameters = $(".product-parameters li button");

    for (var i = 0; i < product_parameters.length; i++) {
        var h3title = $(product_parameters[i]).find("h3");
        if (h3title.attr("class") == "on") {
            $(product_parameters[i]).next().show();
        }
    }

    var currentOnProductPatameters = product_parameters[0];
    product_parameters.click(function() {
        var h3title = $(this).find("h3");
        if (h3title.attr("class") == "off") {
            $(currentOnProductPatameters).next().hide();
            $(currentOnProductPatameters).find("h3").removeClass("on");
            $(currentOnProductPatameters).find("h3").addClass("off");
            $(this).next().show();
            h3title.removeClass("off");
            h3title.addClass("on");
            currentOnProductPatameters = this;
        }
    });

    $("#btn-add-to-cart").click(function() {
        if (!currentSelectedColor) {
            $("#color-tip").show();
            return;
        }
        if (currentSelectedColor) {
            $("#color-tip").hide();
        }
        var quantity = $("#quantity-input").val();
        var $btn = $(this).button('loading')
        $("#add-success").show();
        $btn.button('reset');
    });

    $(".close").click(function() {
        // $(".alert").alert('close');
        $("#add-success").hide();
    });

    var sizeList = $("#size-list")
    $("#selected-size").click(function() {
        if (sizeList.css("display") == "none")
            sizeList.show();
        else
            sizeList.hide();
    });
    $("#size-list li").click(function() {
        $("#selected-size span")[0].innerHTML = $(this).find("span")[0].innerHTML;
        sizeList.hide();
    });
});