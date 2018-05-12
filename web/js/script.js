$(function() {
    // .slick
    var slick = $('.slick');
    if ($(window).width() < 900) {
        slick.not('.slick-initialized').slick({
            dots: false,
            slidesToShow: 1,
            slidesToScroll: 1
        });
        slick.width(260);
    } else {
        slick.width(900);
        slick.not('.slick-initialized').slick({
            dots: false,
            slidesToShow: 3,
            slidesToScroll: 1
        });
    }

    // .faq img
    var faq_img = $(".faq img");
    if ($(window).width() < 640) {
        faq_img.width($(window).width() - 40)
    } else { faq_img.width(640); }

    // .aboutus .cd-fixed-bg
    var fixed_bg = $('.aboutus .cd-fixed-bg');
    var fixed_bg_height = fixed_bg.height();
    $(window).on('scroll', function() {
        var scrollTop = Math.floor(($(window).scrollTop() - fixed_bg.offset().top) / 2);
        // console.log(scrollTop);
        fixed_bg.css('background-position', '50% ' + scrollTop + 'px');
    });

    // .aboutus .cd-fixed-bg .rect
    var rect = $(".aboutus .cd-fixed-bg .rect");
    if ($(window).width() < 940) {
        rect.width(0.53 * $(window).width())
    } else { rect.width(500); }
    rect.css("left", (($(window).width() - rect.width()) / 2) + "px")

    // 获取手指在轮播图元素上的一个滑动方向（左右）

    // 获取界面上轮播图容器
    var $carousels = $('.carousel');
    var startX, endX;
    // 在滑动的一定范围内，才切换图片
    var offset = 50;
    // 注册滑动事件
    $carousels.on('touchstart', function(e) {
        // 手指触摸开始时记录一下手指所在的坐标x
        startX = e.originalEvent.touches[0].clientX;

    });
    $carousels.on('touchmove', function(e) {
        // 目的是：记录手指离开屏幕一瞬间的位置 ，用move事件重复赋值
        endX = e.originalEvent.touches[0].clientX;
    });
    $carousels.on('touchend', function(e) {
        //console.log(endX);
        //结束触摸一瞬间记录手指最后所在坐标x的位置 endX
        //比较endX与startX的大小，并获取每次运动的距离，当距离大于一定值时认为是有方向的变化
        var distance = Math.abs(startX - endX);
        if (distance > offset) {
            //说明有方向的变化
            //根据获得的方向 判断是上一张还是下一张出现
            $(this).carousel(startX > endX ? 'next' : 'prev');
        }
    })
});
$(window).resize(function() {
    // .slick
    var slick = $('.slick');
    if ($(window).width() < 900) {
        slick.slick("unslick");
        slick.not('.slick-initialized').slick({
            dots: false,
            slidesToShow: 1,
            slidesToScroll: 1
        });
        slick.width(260);
    } else {
        slick.width(900);
        slick.slick("unslick");
        slick.not('.slick-initialized').slick({
            dots: false,
            slidesToShow: 3,
            slidesToScroll: 1
        });
    }

    // .faq img
    var faq_img = $(".faq img");
    if ($(window).width() < 640) {
        faq_img.width($(window).width() - 40)
    } else { faq_img.width(640); }

    // .aboutus .cd-fixed-bg .rect
    var rect = $(".aboutus .cd-fixed-bg .rect");
    if ($(window).width() < 940) {
        rect.width(0.53 * $(window).width())
    } else { rect.width(500); }
    rect.css("left", (($(window).width() - rect.width()) / 2) + "px");
});