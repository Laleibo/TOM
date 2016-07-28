class SessionsController < ApplicationController

  def index
  end

  def new
  end

  def create
    @profile = Profile.find_by(email: params[:email])
    if @profile && @profile.authenticate(params[:password])
      session[:user_id] = @profile.id
      redirect_to @profile
    else
      render :new
    end
	end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
