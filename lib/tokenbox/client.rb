class Tokenbox::Client

  def initialize
    @conn = Faraday.new(url: host) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers = headers
    end
  end

  def create_token(institution)
    tokens_params = {
      "institution": institution,
      "type": "OAUTH_OTP",
      "consumer_id": "WOMPI",
      "consumer_redirect_url": "https://hidden-taiga-55264.herokuapp.com/tokenbox_store/redirect",
      "aggregated_merchant": {
          "external_uuid": "787878",
          "doing_business_as_name": "DEMO STORE",
          "legal_name": "DEMO STORE SAS",
          "logo_url": "https://cdn.freebiesupply.com/logos/large/2x/its-demo-logo-png-transparent.png"
      }
    }.to_json

    response = post(url: 'token', json_params: tokens_params)
  end

  private

  def post(url:, json_params:)
    @conn.post do |req|
      req.url(url)
      req.body = json_params
    end
  end

  def headers
    {
      'Authorization' => "Bearer IDDELICETEX",
      'Content-Type' => "application/json",
      'X-Auth-Secret-Key' => "SECRET_01FVWYS8S55J3VW0NZX0QZRZ0Y",
      'X-Auth-Access-Key' => "ACCESS_01FVWYS8WWXV017DA6MPM0F5A9"
    }
  end

  def host
    ENV['TOKENBOX_HOST']
  end


end
