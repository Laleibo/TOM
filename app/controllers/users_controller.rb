class UsersController < ApplicationController

  def index
    @users = User.all
    @profile = Profile.find(params[:profile_id])
  end

  def new
    @users = User.new
    @profile = Profile.find(params[:profile_id])
  end

  def create
    @profile = Profile.find(params[:profile_id])
    # @user = @profile.users.create(user_params)
    @user =  @profile.users.create!({first_name: params[:first_name],last_name: params[:flast_name], birthday: params[:birthday], variety: params[:variety], flow: params[:flow],scent: params[:scent] })

    respond_to do |format|
      if @user.save
        format.html { redirect_to profile_user_path(@profile, @user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: profile_user_path }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @profile = Profile.find(params[:profile_id])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :birthday, :type, :flow, :scent)
    end
end
