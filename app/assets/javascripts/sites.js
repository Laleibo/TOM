$(document).on("turbolinks:load",function(){
	$(".sesssions.new").ready(function(){
		home_page_setup();
	});

	$(".profiles.show").ready(function(){
		profile_show();
	});


	// if(user.id === undefined){
	// 	// alert("Load boxes!");
	// } else {
	// 	// alert("Error");
	// }
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
	pop_functionality(log_in_pop, log_link, log_in_exit);
	pop_functionality(reg_pop, reg_link, reg_exit);

}

function profile_show(){
	var pro_link = $(".sessions.new #new_user");
	var pro_pop = $(".profiles.show .step_container");
	var pro_exit = $(".profiles.show #user_exit");
	pop_set($(".profiles.show .step_container"));
	$(".profiles.show .step_container").hide();
	pop_functionality();
	var user = $(".profiles.show .side_panel").data("user");
	$(".profiles.show #user_exit").click(function(){
		$(".profiles.show .step_container").hide(170);
	});
	$(".profiles.show #new_user").click(function(){
		$(".profiles.show .step_container").show(170);
	});
}

function pop_functionality(pop, link, exit) {
	$(pop).hide();
	$(link).click(function(){
		$(pop).show(function(){
			$(exit).click(function(){
				$(pop).hide(170);
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
});


