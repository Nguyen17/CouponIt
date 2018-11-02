$(document).ready(function() {
    $('.developers').slick({
        accessibility: true,
        autoplay: true,
        autoplaySpeed: 3000,
        arrows: false,
        dots: true,
        mobileFirst: true,
        centerMode: true,
        slidesToShow: 1,
        centerPadding: '40px',
    })

    $('nav .drop-down ul li a').click(function(e) {
        document.getElementById('nav-icon').classList.toggle('change');
        document.getElementById('drop-down').classList.toggle('close');

        
        var targetHref = $(this).attr('href');
        $('html, body').animate({
            scrollTop: $(targetHref).offset().top - 80
        }, 1000);

        e.preventDefault();
    });
})

function scrollToAboutSection() {
    var targetHref = $('#about');
    $('html, body').animate({
        scrollTop: $(targetHref).offset().top - 80
    }, 600);

}

function navIconClicked(e) {
    e.classList.toggle('change');
    document.getElementById('drop-down').classList.toggle('close');
}