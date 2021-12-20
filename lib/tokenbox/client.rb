class Tokenbox::Client

  def initialize
    @conn = Faraday.new(url: host) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers = headers
    end
  end

  def create_token
    tokens_params = {
      "institution": "BANBOX",
      "type": "OAUTH_OTP",
      "consumer_id": "DEMO",
      "redirect_url": "https://redirect.com",
      "aggregated_merchant": {
          "external_uuid": "787878",
          "doing_business_as_name": "DEMO STORE",
          "legal_name": "DEMO STORE SAS",
          "logo_url": "https://cdn.freebiesupply.com/logos/large/2x/its-demo-logo-png-transparent.png"
      }
    }.to_json

    response = post(url: 'tokens', json_params: tokens_params)
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
      'Authorization' => "Bearer IDDELICETEX"
    }
  end

  def host
    ENV['TOKENBOX_HOST']
  end


end
