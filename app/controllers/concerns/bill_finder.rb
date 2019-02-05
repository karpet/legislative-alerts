module BillFinder
  extend ActiveSupport::Concern

  def bill_id
    params.require(:id)
  end

  def bill_details
    # for backcompat, test if we are base64 encoded
    Rails.logger.debug("bill id #{bill_id}")
    OpenStates::Bill.try_find_by_os_bill_id(bill_id, current_user, Rails.logger)
  end
end
