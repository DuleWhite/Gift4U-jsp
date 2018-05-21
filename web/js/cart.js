$(function() {
    $(".btn-add-note").click(function() {
        if ($(".cart-note textarea").css("display") == "none") {
            $(".cart-note textarea").css("display", "block");
        } else {
            $(".cart-note textarea").css("display", "none");
        }
    });
    var distpickerModal = artModal({ //构建artModal实例
        element: document.getElementById('distpicker'),
        open: function() {},
        close: function() {}
    });
    var btnShippingDist = $("#shipping-dist");
    var btnUpdate = $("#btn-update");
    btnShippingDist.click(function() {
        distpickerModal.open();
    });
    btnUpdate.click(function() {
        var ret = "";
        var province = $("#select-province").val();
        var city = $("#select-city").val();
        var area = $("#select-area").val();
        if (province == "");
        else if (city == "");
        else if (area == "");
        else {
            $("#shipping-dist").text(province + ", " + city + ", " + area);
            distpickerModal.close();
        }
    });
    $(".checkout").click(function() {
        var shippingTo = $("#shipping-dist").html();
        $.ajax({
            url:"../CheckoutServlet",
            data:{
                "shippingTo":shippingTo
            },
            async:false,
            success:function (data) {
                if(data!="false") {
                    $(location).attr('href', 'thanks.jsp?orderId=' + data.split("-")[0]
                        + '&totalPrice=' + data.split("-")[1]
                        + '&shippingTo1=' + shippingTo.split(",")[0]
                        + '&shippingTo2=' + shippingTo.split(",")[1].trim()+","+shippingTo.split(",")[2]
                    );
                }
                else{
                    new Toast({context:$("body"),message:'Checkout Failed'}).show();11
                }
            },
            error:function (jqXHR) {
                new Toast({context:$("body"),message:'Checkout Failed ('+jqXHR.status+')'}).show();
            }
        });
    });
    $(".btn-remove").click(function() {
        var parameters = $($($(this).prev()[0]).children());
        var productId = $(parameters[0]).html().split(" ")[1];
        var productColor = "";
        var productSize = "";
        if(parameters.length==4){
            productColor = $(parameters[1]).html().split(" ")[1];
            productSize = $(parameters[2]).html().split(" ")[1];
        }
        else if(parameters.length == 3){
            if($(parameters[1]).html().split(":")[0] == "Color"){
                productColor = $(parameters[1]).html().split(" ")[1];
            }
            else{
                productSize = $(parameters[1]).html().split(" ")[1];
            }
        }

        var success = false;
        var empty = false;
        $.ajax({
            url:"../RemoveCartProductServlet",
            data:{
                "productId":productId,
                "productColor":productColor,
                "productSize":productSize
            },
            async:false,
            success:function (data) {
                success = true;
                if(data=="empty") empty = true;
            },
            error:function (jqXHR) {
                new Toast({context:$("body"),message:'Remove Failed ('+jqXHR.status+')'}).show();
            }
        });
        if(success)$(this).parent().parent().parent().remove();
        if(empty){
            $(".list-header .list-title span").remove();
            $(".list-header .list-parameters").remove();
            $(".empty-cart").css("display", "block");
            $(".list-body").remove();
            $(".summary").remove();
        }
    });

    //Disable '-' at quantity input
    $(".quantity-input").keypress(function () {
        if (event.keyCode == 45) {
            event.preventDefault();
        }
    });

    //Disable '-' at quantity input
    $(".quantity-input").keyup(function(){
        var parameters = $($($($($($($(this)).parent()[0]).parent()[0]).prev()[0]).children()[1]).children()[1]).children();
        var productId = $(parameters[0]).html().split(" ")[1];
        var productColor = "";
        var productSize = "";
        var quantity = $(this).val();
        if(quantity[0]=='-') quantity = quantity.split("-")[1];
        $(this).val(quantity);
        if(parameters.length==4){
            productColor = $(parameters[1]).html().split(" ")[1];
            productSize = $(parameters[2]).html().split(" ")[1];
        }
        else if(parameters.length == 3){
            if($(parameters[1]).html().split(":")[0] == "Color"){
                productColor = $(parameters[1]).html().split(" ")[1];
            }
            else{
                productSize = $(parameters[1]).html().split(" ")[1];
            }
        }
        var ret = "";
        var success = false;
        $.ajax({
            url:"../UpdateCartProductQuantityServlet",
            data:{
                "productId":productId,
                "productColor":productColor,
                "productSize":productSize,
                "quantity":quantity
            },
            async:false,
            success:function (data) {
                success = true;
                ret = data;
            },
            error:function (jqXHR) {
                new Toast({context:$("body"),message:'Change Failed, Please Refresh This Page  ('+jqXHR.status+')'}).show();
            }
        });
        if(success){
            $($($($($(this)).parent()[0]).next()[0]).children(":first")[0]).html("$"+ret.split("-")[0]);
            $("#subtotal").html("$"+ret.split("-")[1]);
            $("#total-price").html("$"+ret.split("-")[1]);
            new Toast({context:$("body"),message:'Change Success'}).show();
        }
    });

});