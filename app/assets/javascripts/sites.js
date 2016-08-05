$(document).on("turbolinks:load",function(){
	$(".sesssions.new").ready(function(){
		home_page_setup();
	});

	$(".profiles.show").ready(function(){
		profile_show();
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
	pop_functionality(log_in_pop, log_link, log_in_exit, reg_pop);
	pop_functionality(reg_pop, reg_link, reg_exit, log_in_pop);
	
	}

	function profile_show(){
		var users = $(".profiles.show .banner").data("users");
		var pro_link = $(".profiles.show #new_user");
		var pro_pop = $(".profiles.show .step_container");
		var pro_exit = $(".profiles.show #user_exit");
		var pro_container = $(".profiles.show .step_container");

		if(users === undefined || users === ''){
	 		// $(pro_exit).css({"display": "none"});
		} else {
			$(pro_pop).hide();
	 		$(".banner").html('Welcome, '+ users);
		}

		pop_set(pro_pop);
		
		$(".profiles.show #user_exit").click(function(){
			$(".profiles.show .step_container").hide(170);
		});
		$(".profiles.show #new_user").click(function(){
			$(".profiles.show .step_container").show(170);
			$(pro_exit).show();
			$("#pro_prevent").hide();
		});
		
		var acc = document.getElementsByClassName("accordion");
		var i;

		for (i = 0; i < acc.length; i++) {
	    	acc[i].onclick = function(){
	        	this.classList.toggle("active");
	        	this.nextElementSibling.classList.toggle("show");
	    	}
	    }

	    $('#your_orders').click(function(e){
	    	var profile_id = $(".profiles.show .navig").data("profile");
	    	$.ajax({
	    		url: '/profiles/'+profile_id,
	    		type: "get"
	    	}).done(function(data){
	    		console.log(data.email);
				$(".profiles.show .main_panel").text('');
				$(".profiles.show .main_panel").append("<p class='dis_title'>Your Profile</p><table class='responsive-table bordered'><tbody><tr><td><strong>Email:</strong></td><td>"+data.email+"</td></tr><tr><td><strong>Address1:</strong></td><td>"+data.address1+"</td></tr><tr><td><strong>Address2:</strong></td><td>"+data.address2+"</td></tr><tr><td><strong>City:</strong></td><td>"+data.city+"</td></tr><tr><td><strong>State:</strong></td><td>"+data.state+"</td></tr><tr><td><strong>Zip:</strong></td><td>"+data.zip+"</td></tr></tbody></table>");
	    	});
	    });

		$(".profiles.show .panel").click(function(e){
			e.preventDefault();
			var profile_id = $(".profiles.show .navig").data("profile");
			var user_id = $(this).data("user");
			$.ajax({
				url:'/use_form',
				type: "post", 
				data: {profile_id: profile_id, user_id: user_id} 
				}).done(function(data){
					$(".profiles.show .main_panel").text('');
					$(".profiles.show .main_panel").append(data);
				});
		});

	}

	function pop_functionality(pop, link, exit, other) {
		$(pop).hide();
		$(link).click(function(){
			$(other).hide();
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
		var top = (win_height/2) - (pop_height/2) - 20;
		$(selected).css({'top': top, 'left': left});
	}
});
