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
      :plan => 'TOM',
      :source  => params[:stripeToken]
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

    Stripe::Subscription.create(
      :customer => customer.id,
      :plan => "TOM",
      :quantity => @profile.users.count
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end



  def hold
    @profile = Profile.find(params[:profile_id])

    if @profile.subscribed == true
      @profile.update(subscribed: false)
    else
      @profile.update(subscribed: true)
    end
    @profile.save

    subscription = Stripe::Subscription.retrieve(@profile.Subscription_id)
    logger.debug("***********#{Stripe::Subscription.retrieve(@profile.Subscription_id)}**********")
    subscription.plan = "TOM"
    subscription.prorate = false
    subscription.quantity = @profile.users.count
    subscription.source = @profile.card_token
    subscription.at_period_end = @profile.subscribed
    subscription.save

    redirect_to profile_path(@profile)
  end

  def show
    @profile = Profile.find(params[:profile_id])
    Stripe::Subscription.retrieve(@profile.subscription_id)
    logger.debug("*************#{Stripe::Subscription.retrieve(@profile.subscription_id)}****************")
  end

  def cancel
    @profile = Profile.find(params[:profile_id])

    if @profile.subscribed == true
      @profile.update(subscribed: false)
    else
      @profile.update(subscribed: true)
    end
    @profile.save

    sub = Stripe::Subscription.retrieve(@profile.Subscription_id)
    sub.at_period_end = @profile.subscribed
      redirect_to profile_path(@profile)
  end




end
