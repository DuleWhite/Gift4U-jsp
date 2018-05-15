$(function() {
    //Variables declare
    var currentSelectedColor = null;
    var productId,productName,productImages,productPrice,productColors,productSizes;
    var currentSelectedImg;
    var sizeListShow;
    var sizeList = $("#size-list");;

    function resetModal() {
        //Clear size options
        $("#size ul").empty();
        //Clear color options
        $("#modal-color ul").empty();
        //Hide size panel
        $("#size").hide();
        //Hide color panel
        $("#modal-color").hide();
        //Set Quantity is 1 as default
        $("#quantity-input").val("1");
        sizeListShow = false;
        $("#modal-productImages").empty();
        $("#color-tip").hide();
        sizeList.hide();
        $("#selected-size span").html("");
    }

    $(".product-qwbtn").click(function () {
        resetModal();
        $.ajax({
            url:"../ProductInfoServlet",
            data:{
                "productId":($($($($(this)).parent()[0]).parent()[0]).prev()[0].innerHTML).split("=")[1]
            },
            async:false,
            success:function(data){
                //Progress data
                var json = $.parseJSON(data);
                productId = json.productId;
                productName = json.productName;
                productImages = json.productImages;
                productPrice = json.productPrice;
                productColors = json.productColors;
                productSizes = json.productSizes;

                //Set product id, product name, product price
                $("#modal-productId").html(productId);
                $("#modal-productName").html(productName);
                $("#modal-productPrice").html("$" + productPrice.toFixed(2));

                //If product has color option then add colors
                if(productColors!=null && productColors.length>0){
                    var modalColor = $("#modal-color");

                    //Set color panel visible
                    modalColor.show();

                    //Add colors dynamically
                    var ul = $("#modal-color ul");
                    for(var i=0;i<productColors.length;i++){
                        $("<li><div class='color-label' style='background-color:"+productColors[i]+";' id='"+productColors[i]+"'></div></li>").appendTo(ul);
                    }

                    //Add click function for each colors, set selected when click and cancel others 'selected' class
                    $(".color-label").click(function() {
                        if (currentSelectedColor) {
                            $(currentSelectedColor).removeClass("selected");
                        }
                        $(this).addClass("selected");
                        currentSelectedColor = this;
                    });
                }

                //If product has size option then add sizes
                if(productSizes!=null && productSizes.length>0){
                    var size = $("#size");

                    //Set size panel visible
                    size.show();

                    //Add sizes dynamically
                    var ul = $("#size-list ul");
                    for(var i=0;i<productSizes.length;i++){
                        $("<li><span>"+productSizes[i]+"</span></li>").appendTo(ul);
                    }

                    //Add click function for each sizes, when select a size change current selected size
                    $("#size-list li").click(function() {
                        $("#selected-size span").html($(this).find("span").html());
                        sizeList.hide();
                    });

                    //Set default selected size as first size
                    $("#selected-size span").html(productSizes[0]);
                }

                //Add product images
                var oldPath,newPath;

                //Add images dynamically
                for(var i=0;i<productImages.length;i++){
                    if(i==0) $("<img class='guide-img selected' src='../img/"+productImages[i]+"'>").appendTo($("#modal-productImages"));
                    else $("<img class='guide-img' src='../img/"+productImages[i]+"'>").appendTo($("#modal-productImages"));
                }

                //Change default zoom-img image src and 'magiczoom-zoom' background image as first image
                oldPath="../img/"+productImages[0];
                newPath=newPath = oldPath.replace(/-s/, "-l");
                $("#zoom-img").attr('src',oldPath);
                $("#magiczoom-zoom").css('background-image', 'url(' + newPath + ')');
                currentSelectedImg = $(".guide-img")[0];

                //Change zoom-img when a not active guide-img selected
                $(".guide-img").click(function() {
                    oldPath = this.src;
                    newPath = oldPath.replace(/-s/, "-l");
                    $("#zoom-img").attr('src', newPath);
                    $("#magiczoom-zoom").css('background-image', 'url(' + newPath + ')');
                    $(currentSelectedImg).removeClass("selected");
                    $(this).addClass("selected");
                    currentSelectedImg = this;
                });
            },
            error:function (jqXHR) {
                alert(jqXHR.status);
            }
        });
        var modal = artModal({
            element:document.getElementById("product-quick-view-modal"),
            close:function () {
                resetModal();
            }
        });
        modal.open();
    });


    //Add click function for each colors, set selected when click and cancel others 'selected' class
    $(".color-label").click(function() {
        if (currentSelectedColor) {
            $(currentSelectedColor).removeClass("selected");
        }
        $(this).addClass("selected");
        currentSelectedColor = this;
    });

    //Add click function for each sizes, when select a size change current selected size
    $("#size-list li").click(function() {
        $("#selected-size span").html($(this).find("span").html());
        sizeList.hide();
    });

    currentSelectedImg = $(".guide-img")[0];
    //Change zoom-img when a not active guide-img selected
    $(".guide-img").click(function() {
        oldPath = this.src;
        newPath = oldPath.replace(/-s/, "-l");
        $("#zoom-img").attr('src', newPath);
        $("#magiczoom-zoom").css('background-image', 'url(' + newPath + ')');
        $(currentSelectedImg).removeClass("selected");
        $(this).addClass("selected");
        currentSelectedImg = this;
    });


    //Open magicZoom
    $("#zoom-img").magicZoom();

    //Open size list when clicked selected-size
    sizeList.hide();
    $("#selected-size").click(function() {
        if (sizeListShow) { sizeList.hide();sizeListShow=false; }
        else { sizeList.show(); sizeListShow = true; }
    });


    //Set Quantity is 1 as default
    $("#quantity-input").val("1");


    //Disable '-' at quantity input
    document.getElementById("quantity-input").addEventListener("keypress", function(event) {
        if (event.keyCode == 45) {
            event.preventDefault();
        }
    });

    //Search and set display which product parameter panel class is 'on'
    var product_parameters = $(".product-parameters li button");
    for (var i = 0; i < product_parameters.length; i++) {
        var h3title = $(product_parameters[i]).find("h3");
        if (h3title.attr("class") == "on") {
            $(product_parameters[i]).next().show();
        }
    }

    //Switch product parameter panel
    var currentOnProductParameters = product_parameters[0];
    product_parameters.click(function() {
        var h3title = $(this).find("h3");
        if (h3title.attr("class") == "off") {
            $(currentOnProductParameters).next().hide();
            $(currentOnProductParameters).find("h3").removeClass("on");
            $(currentOnProductParameters).find("h3").addClass("off");
            $(this).next().show();
            h3title.removeClass("off");
            h3title.addClass("on");
            currentOnProductParameters = this;
        }
    });

    //Add to cart button clicked
    $("#btn-add-to-cart").click(function() {
        if(productColors!=null){
            if (!currentSelectedColor) {
                $("#color-tip").show();
                return;
            }
            if (currentSelectedColor) {
                $("#color-tip").hide();
            }
        }
        var quantity = $("#quantity-input").val();
        var $btn = $(this).button('loading');
        $("#add-success").show();
        setTimeout(function () {
            $("#add-success").hide();
        },1000);
        //TODO: post form
        $.ajax({
            url:"../AddToCartServlet",
            data:{
                "productId":$($($(this)).prev()[0]).html(),
                "color":($($(".color-label.selected")[0]).attr("id"))?($($(".color-label.selected")[0]).attr("id")):"",
                "size":$($("#selected-size span")[0]).html(),
                "quantity":$("#quantity-input").val()
            },
            async:false,
            success:function(data){
                if(data="true"){
                    $btn.button('reset');
                }
                else{
                    alert("Failed to add to cart.");
                }
            },
            error:function () {
                alert("Failed to add to cart.");
            }
        });

    });
});