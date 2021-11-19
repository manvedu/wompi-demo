class Wompi::Client
  TEST_API_LOGIN = "pRRXKOl8ikMmt9u"
  TEST_API_KEY = "4Vj8eK4rloUd272L48hsrarnUA"
  SANDBOX_HOST =  "https://sandbox.api.payulatam.com"

  def initialize
    @conn = Faraday.new(url: host) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers = headers
    end
  end

  def create_payment_source(token:, customer_email:, type:)
    payment_source_params = {
      "acceptance_token": get_acceptance_token,
      "customer_email": customer_email,
      "type": type,
      "token": token
    }.to_json

    response = post(url: 'payment_sources', json_params: payment_source_params)
    if response.success?
       body = JSON.parse(response.body)
       puts "Payment source's info "*10
       puts body
       puts "Payment source's info "*10
       body.fetch("data").fetch("id")
    else
      Rails.logger.error("Error creating payment source")
      raise "error in create payment source"
    end
  end

  def get_acceptance_token
    response = get("merchants/#{ENV['MERCHANT_PUBLIC_KEY']}")
    if response.success?
       body = JSON.parse(response.body)
       body.fetch("data").fetch("presigned_acceptance").fetch("acceptance_token")
    else
      Rails.logger.error("Error getting acceptance token")
      raise "error in get acceptance token"
    end
  end

  private

  def post(url:, json_params:)
    @conn.post do |req|
      req.url(url)
      req.body = json_params
    end
  end

  def get(url)
    @conn.get do |req|
      req.url(url)
    end
  end

  def headers
    {
      'Content-Type' => "application/json; charset=utf-8",
      'Accept' => "application/json",
      'Accept-language' => "es",
      'Authorization' => "Bearer #{ENV['MERCHANT_PRIVATE_KEY']}"
    }
  end

  def host
    ENV['WOMPI_HOST']
  end


end
