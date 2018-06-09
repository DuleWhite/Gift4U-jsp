$(function () {
    $("#getCode1").click(function () {
        var phone = $("#phone").val();
        var phoneExist = false;
        $.ajax({
            url:"../PhoneJudgementServlet",
            data:{
                "phone":phone
            },
            type:"post",
            async:false,
            dataType:"text",
            success : function(data) {
                if(data=="true"){
                    new Toast({context:$("body"),message:'Phone number exist'}).show();
                    phoneExist = true;
                }
            },
            error : function() {
                new Toast({context:$("body"),message:'Unknown error (2)'}).show();
                phoneExist = true;
            }
        });
        if(phoneExist)return;

        $.ajax({
            url:"../MessageServlet",
            data:{
                "phone":$("#phone").val()
            },
            type:"post",
            async:false,
            dataType:"text",
            success : function(data) {
                if(data=='0'){
                    time1(this);
                } else if (data=='51') {
                    new Toast({context:$("body"),message:'Wrong Phone Number'}).show();
                }
                else{
                    new Toast({context:$("body"),message:'Failed To Send.('+data+')'}).show();
                }
            },
            error : function() {
                new Toast({context:$("body"),message:'Unknown Error'}).show();
            }
        });
    });

    $("#getCode2").click(function () {
        var phone = $("#phone").val();
        var phoneExist = true;
        $.ajax({
            url:"../PhoneJudgementServlet",
            data:{
                "phone":phone
            },
            type:"post",
            async:false,
            dataType:"text",
            success : function(data) {
                if(data!="true"){
                    new Toast({context:$("body"),message:'User (phone number) not exist'}).show();
                    phoneExist = false;
                }
            },
            error : function() {
                new Toast({context:$("body"),message:'Unknown Error (2)'}).show();
                phoneExist = false;
            }
        });
        if(!phoneExist)return;

        $.ajax({
            url:"../MessageServlet",
            data:{
                "phone":$("#phone").val()
            },
            type:"post",
            async:false,
            dataType:"text",
            success : function(data) {
                if(data=='0'){
                    time2(this);
                } else if (data=='51') {
                    new Toast({context:$("body"),message:'Wrong Phone Number'}).show();
                }
                else{
                    new Toast({context:$("body"),message:'Failed To Send.('+data+')'}).show();
                }
            },
            error : function() {
                new Toast({context:$("body"),message:'Unknown Error'}).show();
            }
        });
    });

    //验证码倒计时
    var wait = 60;
    function time1(obj) {
        if(wait==0) {
            $("#getCode1").removeAttr("disabled");
            $("#getCode1").html("Send");
            $("#getCode1").css("background-color","rgb(58, 128, 153)");
            wait = 60;
        }else {
            $("#getCode1").attr("disabled","true");
            $("#getCode1").html("Retry in "+wait);
            $("#getCode1").css("background-color","rgb(200, 200, 200)");
            wait--;
            setTimeout(function() {     //倒计时方法
                time1(obj);
            },1000);    //间隔为1s
        }
    }
    function time2(obj) {
        if(wait==0) {
            $("#getCode2").removeAttr("disabled");
            $("#getCode2").html("Send");
            $("#getCode2").css("background-color","rgb(58, 128, 153)");
            wait = 60;
        }else {
            $("#getCode2").attr("disabled","true");
            $("#getCode2").html("Retry in "+wait);
            $("#getCode2").css("background-color","rgb(200, 200, 200)");
            wait--;
            setTimeout(function() {     //倒计时方法
                time2(obj);
            },1000);    //间隔为1s
        }
    }


    $("#signUp").click(function () {
        var username = $("#username").val();
        if(!username || username == ""){
            new Toast({context:$("body"),message:'Username Cannot be empty'}).show();
            return;
        }
        var usernameExist = false;
        $.ajax({
            url:"../UsernameJudgementServlet",
            data:{
                "username":username
            },
            type:"post",
            async:false,
            dataType:"text",
            success : function(data) {
                if(data=="true"){
                    new Toast({context:$("body"),message:'Username exist'}).show();
                    usernameExist = true;
                }
            },
            error : function() {
                new Toast({context:$("body"),message:'Unknown Error(1)'}).show();
                usernameExist = true;
            }
        });
        if(usernameExist)return;

        var code = $("#code").val();
        var codeError = false;
        $.ajax({
            url:"../CodeServlet",
            data:{
                "code":code
            },
            type:"post",
            async:false,
            dataType:"text",
            success : function(data) {
                if(data!="true"){
                    new Toast({context:$("body"),message:'Wrong Verification Code'}).show();
                    codeError = true;
                }
            },
            error : function() {
                new Toast({context:$("body"),message:'Unknown Error(3)'}).show();
                codeError = true;
            }
        });
        if (codeError)return;


        var phone = $("#phone").val();
        $.ajax({
            url:"../SignUpServlet",
            data:{
                "username":username,
                "phone":phone
            },
            type:"post",
            async:false,
            dataType:"text",
            success : function(data) {
                if(data=="true"){ $(location).attr('href', '../index.jsp'); }
                else {
                    new Toast({context:$("body"),message:'Register Failed'}).show();
                }
            },
            error : function() {
                new Toast({context:$("body"),message:'Unknown Error(4)'}).show();
            }
        });
    });
    $("#login").click(function () {
        var code = $("#code").val();
        var codeError = false;
        $.ajax({
            url:"../CodeServlet",
            data:{
                "code":code
            },
            type:"post",
            async:false,
            dataType:"text",
            success : function(data) {
                if(data!="true"){
                    new Toast({context:$("body"),message:'Wrong Verification Code'}).show();
                    codeError = true;
                }
            },
            error : function() {
                new Toast({context:$("body"),message:'Unknown Error (2)'}).show();
                codeError = true;
            }
        });
        if(codeError)return;

        var phone = $("#phone").val();
        $.ajax({
            url:"../LoginServlet",
            data:{
                "phone":phone
            },
            async:false,
            dataType:"text",
            success: function (data) {
                if(data=="true") { $(location).attr('href', '../index.jsp'); }
                else{
                    new Toast({context:$("body"),message:'Login Failed'}).show();
                }
            },
            error:function () {
                new Toast({context:$("body"),message:'Unknown Error (3)'}).show();
            }
        })
    })
});