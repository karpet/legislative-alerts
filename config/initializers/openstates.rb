OpenStates.configure do |config|
  config.api_key = ENV['OPENSTATES_API_KEY']
  config.logger = Rails.logger
end

module OpenStatesExtensions
  module Bill
    def os_url
      sprintf("https://openstates.org/%s/bills/%s/%s",
        state, session, bill_id.gsub(/\W/, '')
      )
    end

    def api_url
      sprintf("https://openstates.org/api/v1/bills/%s/", id)
    end

    def desc
      sprintf("[%s %s] %s", state.upcase, session, title)
    end
  end
end

OpenStates::Bill.include OpenStatesExtensions::Bill
