class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
  end

  def create
    puts "params received from widget "*100
    puts params
    puts "params received from widget "*100
    payment_source_id = Wompi::Client.new.create_payment_source(token: params["payment_source_token"], customer_email: "maria+testing@vlipco.com", type: "CARD")
    puts "payment_source_id "*100
    puts payment_source_id
    puts "payment_source_id "*100

    redirect_to "https://google.com/"
  end
end
