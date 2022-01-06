class TokenboxStoreController < ApplicationController
  def index
  end

  def create
    response = Tokenbox::Client.new.create_token
    info = JSON.parse(response.body)
    
    if response.success?
      authData = info["auth_data"]
      redirect_to authData["redirect_url"]
    else
      flash.now[:alert] = 'Error XXXX'
    end
  end
end
