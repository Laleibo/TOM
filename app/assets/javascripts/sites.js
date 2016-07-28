$(".sessions.index").ready(function(){
	$('.sessions.index .sign_in').hide();
	$('.sessions.index .log_in').click(function(){
		$(this).transition({x: '-30em'}, 500, 'ease', function(){
			$('.sessions.index .sign_in').show();
		});
	});
	$('.sessions.index .create_form').hide();
	$('.sessions.index .create').click(function(){
		$('.sessions.index .create_form').fadeIn("150",function(){
			// $('.sessions.index .header').foggy();
			// $('.sessions.index .index_pic').foggy();
			// $('.sessions.index .steps').foggy();
		});
	});
	$('#create_form_exit').click(function(){
		$('.sessions.index .create_form').hide(function(){
			// $('.sessions.index .header').foggy(false);
			// $('.sessions.index .index_pic').foggy(false);
			// $('.sessions.index .steps').foggy(false);
		});
	});
});