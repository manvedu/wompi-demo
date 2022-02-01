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
      'X-Auth-Secret-Key' => "SECRET_84730754074075045",
      'X-Auth-Access-Key' => "ACCESS_4634543243245"
    }
  end

  def host
    ENV['TOKENBOX_HOST']
  end


end
