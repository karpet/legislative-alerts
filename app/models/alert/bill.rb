class Alert::Bill < Alert
  def self.model_name
    Alert.model_name
  end

  def url_name
    'bills'
  end

  def os_bill
    @_os_bill ||= begin
      OpenStates::Bill.find_by_openstates_id(parsed_query[:os_bill_id])
    rescue Faraday::ResourceNotFound => err
      # if it no longer exists, deactivate the alert
      update!(status: :archived)
      false
    end
  end

  def os_url
    os_bill.os_url + '#actions'
  end

  def check
    if bill_has_changed?(os_bill)
      return update_as_run(os_checksum(os_bill))
    end
  end

  private

  def url_query
    '/' + parsed_query[:os_bill_id]
  end

  def bill_has_changed?(bill)
    return unless bill
    DateTime.parse(bill.action_dates[:last]) > last_run_at
  end
end
