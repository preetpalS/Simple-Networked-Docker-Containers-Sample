
class RandomNumberService < Sinatra::Base
  set :bind, (ENV['RANDOM_NUMBER_SERVICE_BIND'] || '0.0.0.0')
  set :port, (ENV['RANDOM_NUMBER_SERVICE_PORT'] || 8081)
  set :server, :puma

  # Returns a number between 1 and 100 inclusively
  get '/' do
    <<JSON
{"value": "#{rand(1..100)}"}
JSON
  end

  get '/env' do
    ENV.inspect.to_s
  end
end
