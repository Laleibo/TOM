class SessionsController < ApplicationController

  def index
    # if session[:profile_id].nil?
    # else
    #   redirect_to root_path
    # end
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.find_by(email: params[:email].downcase)
    if @profile && @profile.authenticate(params[:password])
      session[:profile_id] = @profile.id
      if @profile.email_confirmed
        sign_in profile
        redirect_back_or profile
      else
        flash.now[:notice] = "Please activate your account by following the instructions in the account confirmation email you received to proceed"
        render 'new'
      end
    else
      flash.now[:error]= "ah ah ah try again!"
      redirect_to new_session_path
    end
	end

  def destroy
   session[:profile_id] = nil
   flash[:notice] = "You have successfully logged out."
   redirect_to root_path
  end
end
