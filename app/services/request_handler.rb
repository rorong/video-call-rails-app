class RequestHandler
  ResponseError = Class.new(StandardError)

  def send_request(url, method = :get)
    response = Net::HTTP.get_response(URI(url))
    raise ResponseError if response.code != '200'

    JSON.parse(response.body)
  end
end