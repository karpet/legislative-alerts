class Alert::Bill < Alert
  def os_bill
    @_os_bill ||= OpenStates::Bill.find_by_openstates_id(parsed_query[:os_bill_id])
  end

  def public_url
    "#{Rails.application.routes.url_helpers.root_url}bills#{url_query}"
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
    last_action_newer = DateTime.parse(bill.action_dates[:last]) > last_run_at
    checksum_changed = checksum != os_checksum(bill)
    last_action_newer || (checksum_changed && checksum.present?)
  end
end
