$(function() {
    // .faq img
    var list = $(".list");
    if ($(window).width() < 1200) {
        list.width($(window).width())
    } else { list.width(1200); }

});
$(window).resize(function() {
    // .faq img
    var list = $(".list");
    if ($(window).width() < 1200) {
        list.width($(window).width())
    } else { list.width(1200); }
})