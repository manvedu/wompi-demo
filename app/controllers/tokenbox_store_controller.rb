class TokenboxStoreController < ApplicationController
  def index
  end

  def payment_redirect
    @paymentData = params[:paymentData]
  end
  
  def create
    if params['payment-method'] == "BANBOX-TO-PAY"
      response = Tokenbox::Payment.new.create_payments
      info = JSON.parse(response.body)
      
      if response.success?
        redirect_to tokenbox_store_payment_redirect_path(paymentData: info)
      else
        flash.now[:alert] = 'Error XXXX'
      end
    else
      response = Tokenbox::Client.new.create_token(params['payment-method'])
      info = JSON.parse(response.body)
      
      if response.success?
        authData = info["auth_data"]
        redirect_to authData["redirect_url"]
      else
        flash.now[:alert] = 'Error XXXX'
      end
    end
  end
end
