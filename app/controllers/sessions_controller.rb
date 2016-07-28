class SessionsController < ApplicationController
 
  def index
  	@profile = Profile.new
  	render 'index'
  end

  def new
  	# @profile = Profile.new
  end

  def create 
  	@user = Profiles.
		find_by(username: params[:username]).
			try(:authenticate, params[:password])

		return render action: 'new' unless @user

		# logged in, hooray

		session[:user_id] = @user.id

		redirect_to notes_path

	end
end
