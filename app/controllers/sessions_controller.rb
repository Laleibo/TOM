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
        flash.now[:error] = "Please activate your account by following the instructions in the account confirmation email you received to proceed"
        render 'new'
      end
    else
      flash.now[:error]= "invalid email or password confirmation"
      render 'new'
    end
    #   redirect_to profile_path(@profile)
    # else
    #   render :new
    # end
	end

  def destroy
    session[:profile_id] = nil
    redirect_to root_path
    # render 'sessions/new'
  end
end
