OpenStates.configure do |config|
  config.api_key = ENV['OPENSTATES_API_KEY']
  config.logger = Rails.logger
end
