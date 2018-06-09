$(function () {

    var productId,productName,productImages,productPrice,productColors,productSizes;
    var currentSelectedColor;

    $.ajax({
        url:"../ProductInfoServlet",
        data:{
            "productId":($($("#btn-add-to-cart")).prev()[0].innerHTML).split("=")[1]
        },
        async:false,
        success:function(data) {
            //Progress data
            var json = $.parseJSON(data);
            productId = json.productId;
            productName = json.productName;
            productImages = json.productImages;
            productPrice = json.productPrice;
            productColors = json.productColors;
            productSizes = json.productSizes;
        },
        error:function (jqXHR) {
            new Toast({context:$("body"),message:'Get Product Info Failed(Servlet:'+jqXHR.status+')'}).show();
        }
    });

    $(".color-label").click(function() {
        currentSelectedColor = this;
    });

    //Add to cart button clicked
    $("#btn-add-to-cart").click(function() {
        if(productColors!=null){
            if (!currentSelectedColor) {
                new Toast({context:$("body"),message:'Select color first'}).show();
                return;
            }
        }
        var productId = $($($(this)).prev()[0]).html().split('=')[1];
        if(productColors!=null) {
            var color = ($($(".color-label.selected")[0]).attr("id")) ? ($($(".color-label.selected")[0]).attr("id")) : "";
        }
        if(productSizes!=null) {
            var size = $($("#selected-size span")[0]).html();
        }
        var quantity = Math.abs(parseInt($("#quantity-input").val()));
        if(!quantity){
            new Toast({context:$("body"),message:'Illegal quantity number'}).show();
            return;
        }
        $("#quantity-input").val(quantity);
        var $btn = $(this).button('loading');
        var failedToAddToCart = false;
        $.ajax({
            url:"../AddToCartServlet",
            data:{
                "productId": productId,
                "color": color,
                "size":size,
                "quantity":quantity
            },
            async:false,
            success:function(data){
                if(data=="noLogin"){
                    new Toast({context:$("body"),message:'You have to Login/Sign up first'}).show();
                }
                else if(data=="true"){
                    new Toast({context:$("body"),message:'Add to cart successfully'}).show();
                }
                else{
                    new Toast({context:$("body"),message:'Failed to add to cart'}).show();
                    failedToAddToCart = true;
                }
            },
            error:function (jqXHR) {
                new Toast({context:$("body"),message:'Failed to add to cart (Servlet:'+jqXHR.status+')'}).show();
                failedToAddToCart = true;
            }
        });
        $btn.button('reset');
    });
});