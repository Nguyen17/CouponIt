
new  AOS.init();


$(document).scroll(function(event){
    
    var scrollPos = $(window).scrollTop();
    // console.log(scrollPos);

        if(scrollPos >= 2318){
            $(".navbar h3").css({"color":"#ac1886"});
            $(".navbar a").css({"color":"#ac1886"});
            $("fa fa-navicon").css({"color":"#ac1886"});
        }
        if(scrollPos < 2318){
            $(".navbar h3").css({"color":"white"});
            $(".navbar a").css({"color":"white"});
            $("fa fa-navicon").css({"color":"white"});
        }
    // if(scrollPos >= 423){
    //     $(".fixed-navbar").css({"height": "70px"});
    //     $(".fixed-navbar img").css({"height": "70px"});
    //     $(".fixed-navbar  #menu-icon").css({"height": "40px"});
    // }
    // else{
    //     $(".fixed-navbar").css({"height": "0px"});
    //     $(".fixed-navbar img").css({"height": "0px"});
    //     $(".fixed-navbar #menu-icon").css({"height": "0px"});
    // };


});