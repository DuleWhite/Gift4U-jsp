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
                    alert("Phone number exist.");
                    phoneExist = true;
                }
            },
            error : function() {
                alert("Unknown Error(2)");
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
                    alert("Wrong Phone Number");
                }
                else{
                    alert("Failed To Send.("+data+")");
                }
            },
            error : function() {
                alert("Unknown Error");
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
                    alert("User (phone number) not exist.");
                    phoneExist = false;
                }
            },
            error : function() {
                alert("Unknown Error(2)");
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
                    alert("Wrong Phone Number");
                }
                else{
                    alert("Failed To Send.("+data+")");
                }
            },
            error : function() {
                alert("Unknown Error");
            }
        });
    });

    //验证码倒计时
    var wait = 60;
    function time1(obj) {
        if(wait==0) {
            $("#getCode1").removeAttr("disabled");
            $("#getCode1").html("Send");
            wait = 60;
        }else {
            $("#getCode1").attr("disabled","true");
            $("#getCode1").html("Retry in "+wait);
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
            wait = 60;
        }else {
            $("#getCode2").attr("disabled","true");
            $("#getCode2").html("Retry in "+wait);
            wait--;
            setTimeout(function() {     //倒计时方法
                time2(obj);
            },1000);    //间隔为1s
        }
    }


    $("#signUp").click(function () {
        var username = $("#username").val();
        if(!username || username == ""){
            alert("Username Cannot be empty.");
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
                    alert("Username exist.");
                    usernameExist = true;
                }
            },
            error : function() {
                alert("Unknown Error(1)");
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
                    alert("Wrong Verification Code.");
                    codeError = true;
                }
            },
            error : function() {
                alert("Unknown Error(3)");
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
                else { alert("Register Failed."); }
            },
            error : function() { alert("Unknown Error(4)"); }
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
                    alert("Wrong Verification Code.");
                    codeError = true;
                }
            },
            error : function() {
                alert("Unknown Error(2)");
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
                else{ alert("Login Failed"); }
            },
            error:function () { alert("Unknown Error(3)"); }
        })
    })
});