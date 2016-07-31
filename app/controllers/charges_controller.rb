class ChargesController < ApplicationController

  skip_before_filter  :verify_authenticity_token
def index
end

  def new
      @amount = 800   #current.user.
    end

  def create
    @profile = Profile.find(params[:profile_id])

    # Amount in cents
    @amount = 800

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'TOM Box Supscription',
      :currency    => 'usd'
    )

    require "stripe"
    Stripe.api_key = "sk_test_MIY6hsjxsAyS0miuYJSEdcau"

    Stripe::Plan.create(
    :id       => "TOM Box",
    :amount   => @amount,
    :currency => 'usd'

    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
