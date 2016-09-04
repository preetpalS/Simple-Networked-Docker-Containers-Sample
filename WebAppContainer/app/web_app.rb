
require 'net/http'

class RandomNumberServiceConnection
  BIND = ENV['RANDOM_NUMBER_SERVICE_BIND'] || '0.0.0.0'
  PORT = ENV['RANDOM_NUMBER_SERVICE_PORT'] || 8081
  SERVICE_URI = URI("http://#{BIND}:#{PORT}/")

  class << self
    def json_response
      Net::HTTP.start(SERVICE_URI.host, SERVICE_URI.port) do |http|
        http.request Net::HTTP::Get.new(SERVICE_URI)
      end.body
    end
  end
end

class WebApp < Sinatra::Base
  set :bind, (ENV['WEB_APP_BIND'] || '0.0.0.0')
  set :port, (ENV['WEB_APP_PORT'] || 8080)
  set :server, :puma

  # Returns a number between 1 and 100 inclusively
  get '/' do
    erb :index
  end

  get '/random' do
    RandomNumberServiceConnection.json_response
  end
end
