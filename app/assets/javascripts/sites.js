$(document).on("turbolinks:load",function(){
	$(".sessions.new").ready(function(){
		home_page_setup();
	});

	$(".profiles.show").ready(function(){
		profile_show();
	});

	$(".profiles.invoice").ready(function(){
		profile_invoice();
	});

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
	 		pop_set(pro_pop);
	 		$(pro_pop).show();
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

		var acc = $(".profiles.show .accordion");
		var panel = $(".profiles.show .panel")
		var i;
		if(acc.length > 0){
	  	acc[0].onclick = function(){
	      	this.classList.toggle("active");
	      	$(".panel").toggle("sho");
	  	}
  	}

  	$('#your_orders').click(function(e){
    	var profile_id = $(".profiles.show .navig").data("profile");
    	$.ajax({
    		url: '/profiles/'+profile_id,
    		type: "get"
    	}).done(function(data){
    	var d = "<p class='dis_title'>Your Profile</p><table class='responsive-table bordered'><tbody>";
    	if(isBlank(data.email) === false){
    		d = d.concat("<tr><td><strong>Email:</strong></td><td>"+data.email+"</td></tr>");
    	}
    	if(isBlank(data.address1) === false){
    		d = d.concat("<tr><td><strong>Address1:</strong></td><td>"+data.address1+"</td></tr>");
    	}
    	if(isBlank(data.address2) === false){
    		d = d.concat("<tr><td><strong>Address2:</strong></td><td>"+data.address2+"</td></tr>");
    	}
    	if(isBlank(data.city) === false){
    		d = d.concat("<tr><td><strong>City:</strong></td><td>"+data.city+"</td></tr>");
    	}
    	if(isBlank(data.state) === false){
    		d = d.concat("<tr><td><strong>State:</strong></td><td>"+data.state+"</td></tr>");
    	}
    	if(isBlank(data.zip) === false){
    		d = d.concat("<tr><td><strong>Zip:</strong></td><td>"+data.zip+"</td></tr>");
    	}
    	d = d.concat("</tbody></table>");
    	console.log(d);
			$(".profiles.show .main_panel").text('');
			$(".profiles.show .main_panel").append(d);
    	});
    });

	 	$("#user_profile").click(function(e){
			e.preventDefault();
			var profile_id = $(".profiles.show .navig").data("profile");
			var user_id = $(this).data("user");
			$.ajax({
				url:'/user_form/' + user_id,
				type: "post",
				data: {profile_id: profile_id, user_id: user_id}
				}).done(function(data){
					$(".profiles.show .main_panel").text('');
					$(".profiles.show .main_panel").append(data);
					edit_user();
				});
		});

		$("#delivery").click(function(){
		var profile_id = $(".profiles.show .navig").data("profile");
		$.ajax({
			url:'/profiles/'+profile_id+'/delivery',
			type: 'get'
		}).done(function(data){
				$(".profiles.show .main_panel").text('');
				$(".profiles.show .main_panel").append(data);
			});
		});

		$(".profiles.show .main_panel span").click(function(){
			$.ajax({
				ur:'/add_address'
			}).done(function(data){
				// console.log(data);
			});
		});

		$(".profiles.show .panel").click(function(e){
			e.preventDefault();
			var profile_id = $(".profiles.show .navig").data("profile");
			var user_id = $(this).data("user");
			$.ajax({
				url:'/user_form/' + user_id,
				type: "post",
				data: {profile_id: profile_id, user_id: user_id}
				}).done(function(data){
					$(".profiles.show .main_panel").text('');
					$(".profiles.show .main_panel").append(data);
					edit_user();
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
		var top = (win_height/2) - (pop_height/2) - 45;
		$(selected).css({'top': top, 'left': left});

	}

	function profile_invoice(){

	}

	function isBlank(str) {
    return (!str || /^\s*$/.test(str));
	}

	function edit_user(){
		$("#user_edit").on("click",function(e){
						e.preventDefault();
						var profile_id = $(".profiles.show .navig").data("profile");
						var user_id = $('#user_profile').data("user");
						$.ajax({
							url:'/new_form/' + user_id,
							type: "get",
							data: {profile_id: profile_id, user_id: user_id}
							}).done(function(data){
								$(".profiles.show .main_panel").text('');
								$(".profiles.show .main_panel").append(data);
							});
					});
	}
