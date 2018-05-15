$(function () {
    $("#signUp").click(function () {
        alert("here");
        $.ajax({
            url:"TestServlet",
            async:false,
            success:function(data){
                alert(data);
            },
            error:function (jqXHR) {
                alert(jqXHR.status);
            }
        });
    });
})