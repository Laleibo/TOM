class UsersController < ApplicationController
  before_action :set_profile, only: [:index, :new, :create, :show, :update, :edit, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

def create
  @user = @profile.users.create!(user_params)
  created_product = Product.user_pref(@user)
  Order.create!(user_id: @user.id, product_id: created_product.id)
  redirect_to profile_user_path(@profile, @user), notice: "User was successfully created"

  # respond_to do |format|
  #   if @user.save
  #
  #     product = Product.user_pref(@user)
  #     Order.create!(user: @user, product: product)
  #
  #     format.html { redirect_to profile_user_path(@profile, @user), notice: 'User was successfully created.' }
  #     format.json { render :show, status: :created, location: profile_user_path }
  #   else
  #     format.html { render :new }
  #     format.json { render json: @user.errors, status: :unprocessable_entity }
  #   end
  # end
end
  def show
    @user = User.find(params[:id])

  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_user_path(@profile, @user), notice: 'User was successfully updated.' }
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
      params.require(:user).permit(:first_name, :last_name, :birthday, :variety, :flow, :scent)
    end

    def set_profile
      @profile = Profile.find(params[:profile_id])
    end

    def set_user
      @user = User.find(params[:id])
    end
end
