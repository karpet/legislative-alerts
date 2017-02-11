OpenStates.configure do |config|
  config.api_key = ENV['OPENSTATES_API_KEY']
  config.logger = Rails.logger
end

module OpenStatesExtensions
  module Bill
    def url
      sprintf("https://openstates.org/%s/bills/%s/%s",
        state, session, bill_id.gsub(/\W/, '')
      )
    end
  end
end

OpenStates::Bill.include OpenStatesExtensions::Bill
