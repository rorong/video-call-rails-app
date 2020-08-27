require 'net/http'
require 'json'

module RequestLogger
  def log_request(service, url, method = :get)
    puts "[#{service}] #{method.upcase} #{url}"
  end	
end