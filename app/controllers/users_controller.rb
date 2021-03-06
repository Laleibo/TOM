class UsersController < ApplicationController
  before_action :set_profile, only: [:index, :new, :create, :show, :update, :edit, :destroy]
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = @profile.users.create(user_params)
    if @user.save
      created_product = Product.user_pref(@user)
      Order.create(user_id: @user.id, product_id: created_product.id) rescue nil
      redirect_to profile_path(@profile), notice: "User was successfully created"
    else
      render :new
    end
  end

  def show
  end

  def ajax
    @user = User.find(params[:id])
    @profile = Profile.find(params[:profile_id])
    if request.xhr?
      render '_user',  layout: false
    end
  end

  def edit
    @user = User.find(params[:id])
    @profile = Profile.find(params[:profile_id])
    if request.xhr?
      render '_new',  layout: false
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_path(@profile), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :birthday, :variety, :flow, :scent)
    end

    def set_profile
      @profile = Profile.find(params[:profile_id])
    end

    def set_user
      @user = User.find(params[:id])
    end
end
