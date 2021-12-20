class TokenboxStoreController < ApplicationController
  def index
  end

  def create
    response = Tokenbox::Client.new.create_token
    info = JSON.parse(response.body)
    
    if response.success?
      authData = info["auth_data"]

      # can be removed when redirect url is fixed in back
      uri = URI(authData["redirect_url"])
      id = info["id"]
      
      paths = uri.path.split("/")
      remove = paths.pop
      cleanPaths = paths.join("/")

      baseUrl = uri.to_s
      pathsToString = uri.path.to_s

      urlSlicePaths = baseUrl.slice! pathsToString

      finalUrl = URI.join(baseUrl,cleanPaths)

      redirect_to "#{finalUrl}/#{id}"

      ####################################################
      
      # redirect_to authData["redirect_url"]
    else
      flash.now[:alert] = 'Error XXXX'
    end
  end
end
