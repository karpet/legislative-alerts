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

    def url_id
      Base64.urlsafe_encode64(sprintf("%s/%s/%s", state, session, bill_id))
    end

    def api_url
      sprintf("https://openstates.org/api/v1/bills/%s/", url_id)
    end

    def desc
      sprintf("[%s %s] %s", state.upcase, session, title)
    end
  end
end

OpenStates::Bill.include OpenStatesExtensions::Bill

class OpenStates::Bill
  def self.find_by_os_bill_id(bill_id)
    state, session, bid = Base64.urlsafe_decode64(bill_id).split('/')
    bid = bid.gsub(' ', '%20')
    bill_details(state, session, bid)
  end

  def self.try_find_by_os_bill_id(bill_id, current_user, logger)
    begin
      Base64.urlsafe_decode64(bill_id)
      logger.debug("decode64 ok")
      OpenStates::Bill.find_by_os_bill_id(bill_id)
    rescue ArgumentError => _err
      return unless current_user
      # first 2 letters are state, but we don't know session or bill name.
      logger.warn("Invalid base64 #{bill_id} -- looking for alert")
      alert = current_user.find_alert_for_bill(bill_id)
      logger.warn("Found alert #{alert} new id #{alert.new_bill_id}")
      OpenStates::Bill.find_by_os_bill_id(alert.new_bill_id)
    end
  end
end
