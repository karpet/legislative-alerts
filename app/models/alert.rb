class Alert < ApplicationRecord
  belongs_to :user

  before_create :generate_uuid

  enum type: { bill: 0, search: 1 }

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
    JSON.parse(query, symbolize_keys: true)
  end

  # execute the query and determine if anything has changed
  def check
    if type == :bill
      check_bill
    elsif type == :search
      check_search
    end
  end

  private

  def check_bill
    bill = OpenStates::Bill.find_by_os_id(parsed_query[:os_bill_id])
    if bill_has_changed?(bill)
      return update_as_run(os_checksum(bill))
    end
  end

  def bill_has_changed?(bill)
    last_action_newer = DateTime.parse(bill.action_dates[:last]) > last_run_at
    checksum_changed = checksum != os_checksum(bill)
    last_action_newer || checksum_changed
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
