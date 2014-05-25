$(document).ready(function(){
    //convert datatable's tr to link
	$("tr[data-link]").click(function() {
	  window.location = $(this).data("link")
	});

    // Toggle the name tooltip in tickets data table
    $(".info_tooltip").tooltip();
});

$(document).ready(function () {
    var menu = $('.ticket-menubar');
    var origOffsetY = menu.offset().top;

    function scroll() {
        if ($(window).scrollTop() >= origOffsetY) {
            $('.ticket-menubar').addClass('sticky');
            $('.ticket-body').addClass('menu-padding');
        } else {
            $('.ticket-menubar').removeClass('sticky');
            $('.ticket-body').removeClass('menu-padding');
        }
    }
    document.onscroll = scroll;
});