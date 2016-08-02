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
    @profile = Profile.find_by(email: params[:email])
    if @profile && @profile.authenticate(params[:password])
      session[:profile_id] = @profile.id
      redirect_to profile_path(@profile)
    else
      render :new
    end
	end

  def destroy
    session[:profile_id] = nil
    redirect_to root_path
    # render 'sessions/new'
  end
end
