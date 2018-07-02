(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v2.7";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

$(function(){
    $('.btn-anchor').click(function(){
		$('html, body').animate({
        scrollTop: $( $.attr(this, 'href') ).offset().top}, 750);
		return false;
	});
    $('.dropdown').hover(function(){
        $('.dropdown-toggle', this).trigger('click');
    });

    $('.modal').on('shown.bs.modal', function (e) {
        $('html').addClass('freezePage');
        $('body').addClass('freezePage');
        $('.slider-modal').resize();
        $('.slider-modal').slick("setPosition", 0);
    });
    $('.modal').on('hidden.bs.modal', function (e) {
        $('html').removeClass('freezePage');
        $('body').removeClass('freezePage');
    });

    $('.slider-modal').slick({
        dots: true,
//        autoplay: true,
    });
});

var Sticky = new hcSticky('.sidebar', {
    stickTo: '.content',
    innerTop: -80,
    queries: {
        980: {
            disable: true
        }
    }
});

$('.btn-like').click(function(){
    $(this).find('i').toggleClass('far fas')
});
$('.btn-smile').click(function(){
    $(this).find('i').toggleClass('far fas')
});
$('.btn-meh').click(function(){
    $(this).find('i').toggleClass('far fas')
});
$('.btn-frown').click(function(){
    $(this).find('i').toggleClass('far fas')
});
