$(document).on("turbolinks:load",function(){
	home_page_setup();
	pop_set($(".profiles.show .step_container"))

	var user = $(".profiles.show .side_panel").data("user");
	if(user.id === undefined){
		// alert("Load boxes!");
	} else {
		// alert("Error");
	}
});

function home_page_setup(){
	
	var log_link = $(".sessions.new #login_link");
	var log_in_pop = $(".sessions.new #login_pop");
	var log_in_exit = $(".sessions.new #log_in_exit");
	var reg_link = $(".sessions.new #register_link");
	var reg_pop = $(".sessions.new #register_pop");
	var reg_exit = $(".sessions.new #register_exit");
	pop_set($(".sessions.new .index_pop"));
	
	$(window).resize(function(){
		pop_set($(".sessions.new .index_pop"));
	});

	$(log_in_pop).hide();
	$(log_link).click(function(){
		$(log_in_pop).show(function(){
			$(log_in_exit).click(function(){
				$(log_in_pop).hide(170);
			});
		});
	});

	$(reg_pop).hide();
	$(reg_link).click(function(){
		$(reg_pop).show(function(){
			$(reg_exit).click(function(){
				$(reg_pop).hide(170);
			});
		});
	});

}

function pop_set(selected){
	var win_width = $(window).width();
	var win_height = $(window).height();
	var pop_width = $(selected).width();
	var pop_height = $(selected).height();
	var left = (win_width/2) - (pop_width/2);
	var top = (win_height/2) - (pop_height/2);
	$(selected).css({'top': top, 'left': left});
}
