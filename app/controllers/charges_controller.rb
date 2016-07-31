class ChargesController < ApplicationController

skip_before_filter  :verify_authenticity_token

  def index
  end

  def new
    end

  def create
  @profile = Profile.find(params[:profile_id])
    token = params[:stripeToken]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken],
      :plan   => TOM,
      :id => @profile.id
    )
    @profile.subscribed = true
    # @profile.stripe_id = @profile.id
    @profile.save

    # # save the customer ID in your database so you can use it later
    # save_stripe_customer_id(@profile, customer.id)
    #
    # # later
    # customer_id = get_stripe_customer_id(@profile)

    # plan = Stripe::Plan.create(
    # :id       => 'TOM',
    # :amount   => 900,
    # :currency => 'usd',
    # :interval => 'month',
    # :name     =>  'TOM Monthly Box',
    # :statement_descriptor => "TOM Box Subscription"
    # )

    Stripe::Subscription.create(
      :customer => @profile.id,
      :plan => "TOM",
      :quantity => @profile.users.count
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end


  def show
    @profile = Profile.find(params[:profile_id])
    Stripe::Subscription.retrieve("#{@profile.id}")
  end

  def update
    @profile = Profile.find(params[:profile_id])

    Stripe::Subscription.retrieve("#{@profile.id}")
    @subscription = Stripe::Subscription.retrieve("#{@profile.id}")
    @subscription.plan = "TOM",
    @subscription.prorate = false,
    @subscription.quantity = @profile.users.count,
    @subscription.source = @profile.card_token,
    @subscription.save
end

  # def cancel
  #   @profile = Profile.find(params[:profile_id])
  #
  #   sub = Stripe::Subscription.retrieve(@profile.stripe_id)
  #   sub.at_period_end = true,
  #   sub.delete
  # end

  def destroy
   customer = Stripe::Customer.retrieve("#{@profile.id}")
   customer.subscriptions.retrieve(@profile.subscribed).delete
   @profile.update(subscribed: nil)

   redirect_to root_path, notice: "Your subscription has been canceled."
 end


end
