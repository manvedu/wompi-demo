class Tokenbox::Payment

  def initialize
    @conn = Faraday.new(url: host) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers = headers
    end
  end

  def create_payments
    payments_params = {
      "amount_in_cents": 1000000,
      "currency": "COP",
      "type": "AUTOMATIC_PAYMENT",
      "token_id": "01FSZ9NAE87YBSTHZQBXP6BY43",
      "terminal_id": "03218738790321ASIUHJASDH",
      "reference": ((0...8).map { (65 + rand(26)).chr }.join)
    }.to_json

    response = post(url: 'payments', json_params: payments_params)
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
      'Content-Type' => "application/json",
      'X-Auth-Secret-Key' => "SECRET_01FVWYS8S55J3VW0NZX0QZRZ0Y",
      'X-Auth-Access-Key' => "ACCESS_01FVWYS8WWXV017DA6MPM0F5A9"
    }
  end

  def host
    ENV['TOKENBOX_HOST']
  end


end
