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
      :email => @profile.email,
      :source  => params[:stripeToken],
      :plan => "TOM",
      :quantity => @profile.users.count
      )
    @profile.subscribed = true
    @profile.stripe_id = customer.id
    @profile.card_token = customer.default_source
    @profile.Subscription_id = customer.subscriptions.data[0].id
    @profile.save!

          # plan = Stripe::Plan.create(
          # :id       => 'TOM',
          # :amount   => 900,
          # :currency => 'usd',
          # :interval => 'month',
          # :name     =>  'TOM Monthly Box',
          # :statement_descriptor => "TOM Box Subscription"
          # )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

 def update
   @profile = Profile.find(params[:profile_id])

  customer = Stripe::Customer.retrieve(@profile.stripe_id)
    customer.quantity = @profile.users.count
    customer.source = @profile.card_token
    customer.email = @profile.email
    customer.save!

   redirect_to profile_path(@profile)

end

  def show
    @profile = Profile.find(params[:profile_id])
  Stripe::Customer.retrieve(@profile.stripe_id)
  end

  def cancel
    @profile = Profile.find(params[:profile_id])

    if @profile.subscribed == true
      @profile.update(subscribed: false)
    else
      @profile.update(subscribed: true)
    end
    @profile.save

    cu = Stripe::Customer.retrieve(@profile.stripe_id)
    cu.delete
      redirect_to profile_path(@profile)
  end




end
