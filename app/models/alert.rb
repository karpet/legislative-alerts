class Alert < ApplicationRecord
  belongs_to :user

  before_create :generate_uuid

  enum alert_type: { bill: 0, search: 1 }

  def to_param
    uuid
  end

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def pretty_query
    query
  end

  def parsed_query
    JSON.parse(query, symbolize_names: true)
  end

  def url_query
    if alert_type == 'bill'
      '/' + parsed_query[:os_bill_id]
    else
      '?' + parsed_query.to_query
    end
  end

  # execute the query and determine if anything has changed
  def check
    method_name = "check_#{alert_type}"
    send method_name
  end

  def public_url
    os_bill.os_url + '#actions'
  end

  private

  def os_bill
    @_os_bill ||= OpenStates::Bill.find_by_os_id(parsed_query[:os_bill_id])
  end

  def check_bill
    if bill_has_changed?(os_bill)
      return update_as_run(os_checksum(os_bill))
    end
  end

  def bill_has_changed?(bill)
    last_action_newer = DateTime.parse(bill.action_dates[:last]) > last_run_at
    checksum_changed = checksum != os_checksum(bill)
    last_action_newer || (checksum_changed && checksum.present?)
  end

  def os_checksum(os_payload)
    Digest::SHA256.digest os_payload.to_json
  end

  def check_search
  end

  def update_as_run(checksum)
    update_columns(last_run_at: Time.zone.now, checksum: checksum)
  end
end
