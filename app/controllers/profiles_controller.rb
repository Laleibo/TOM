class ProfilesController < ApplicationController
  before_filter :authorize, except: [:create, :new]
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :delivery, :hold, :invoice]


  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @users = @profile.users.all
    if @users.blank? then
      @first=""
    else
      @first= @users.first.first_name
    end
    @user = User.new
    if request.xhr?
      render @profile
    end

  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
    def create
      @profile = Profile.new(profile_params)
      # respond_to do |format|

  # this section is the old way, the second section I added for email confirm, keep this section just in case we toss the other. #

        # if @profile.save
        #   session[:profile_id] = @profile.id
        #   format.html { redirect_to profile_path(@profile), notice: 'Profile was successfully created.' }
        #   format.json { render :show, status: :created, location: @profile }
        # else
        #   format.html { redirect_to new_session_path, notice: 'Profile was not successfully created, please ensure to fill in all forms.' }
        #   format.json { render json: @profile.errors, status: :unprocessable_entity }
        # end

      if @profile.save
        session[:profile_id] = @profile.id
        ProfileMailer.registration_confirmation(@profile).deliver
        flash[:success] = "Please confirm your email address to continue"
        redirect_to profile_path(@profile)
      else
        flash[:error] = "Ah ah ah.... try again."
        redirect_to new_session_path
      end
    # end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(delivery_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delivery
  end

def invoice
end

  def confirm_email
    profile = Profile.find_by_confirm_token(params[:id])
    if profile
      profile.email.active
      flash[:success] = "Welcome to TOM! Your email has been confirmed. Please sign in to continue."
      redirect_to '/login'
    else
      flash[:error] = "Sorry that profile does not exist."
      redirect_to @profile
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_in_params
      params.require(:profile).permit(:email, :password, :password_confirmation)
    end

    def stripe_params
      params.permit :stripeEmail, :stripeToken
    end

    def delivery_params
      params.require(:profile).permit(:address1, :address2, :city, :state, :zip, :delivery)
    end

    def profile_params
      params.require(:profile).permit(:email, :password, :password_confirmation, :address1, :address2, :city, :state, :zip, :delivery)
    end

end
