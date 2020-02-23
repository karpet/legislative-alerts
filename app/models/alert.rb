class Alert < ApplicationRecord
  self.inheritance_column = :alert_type

  enum status: { active: 'active', archived: 'archived', errored: 'errored' }

  belongs_to :user

  before_create :generate_uuid

  scope :search, -> { where(alert_type: 'Alert::Search') }
  scope :bill, -> { where(alert_type: 'Alert::Bill') }
  scope :recent, -> { order(created_at: 'desc') }
  scope :by_name, -> { order('LOWER(name)') }

  attr_accessor :payload_string

  def self.humanize_query(query)
    clauses = []
    query.each do |k, v|
      next unless v.present?
      label = k == 'q' ? '' : k
      op = k == 'q' ? '' : ':'
      clauses << "#{label}#{op}#{v}"
    end
    clauses.join(' AND ')
  end

  def self.prune_query(query)
    query.slice(:q, :state).reject { |k,v| v.blank? }
  end

  def url_name
    'alerts/'
  end

  def public_url
    "#{Rails.application.routes.url_helpers.root_url}#{url_name}#{url_query}"
  end

  def url_query
    uuid
  end

  def to_param
    uuid
  end

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def pretty_query
    query
  end

  def has_query?(possible_query)
    self.class.prune_query(parsed_query).to_json == possible_query.to_json
  end

  def parsed_query
    JSON.parse(query, symbolize_names: true)
  rescue # if alert was hand-edited it may not be valid JSON anymore
    { q: query.to_s }
  end

  def mark_as_sent
    update_columns(last_sent_at: Time.zone.now)
  end

  def os_checksum(os_payload)
    self.payload_string = os_payload.to_json
    checksum = Digest::SHA256.hexdigest self.payload_string
    Rails.cache.write("alert-#{id}-#{checksum}", self.payload_string)
    checksum
  end

  def checksum_short
    (checksum || 'nocheck')[0..7]
  end

  private

  def write_payload_diff(sum)
    old_key = "alert-#{id}-#{checksum}"
    new_key = "alert-#{id}-#{sum}"
    old_payload = Rails.cache.fetch(old_key) { "{}" } # empty hash if not found
    new_payload = self.payload_string
    diff = Hashdiff.diff(JSON.parse(old_payload), JSON.parse(new_payload))
    Rails.cache.write("alert-#{id}-#{sum}-diff", diff)
  end

  def update_as_run(sum)
    write_payload_diff(sum)
    update!(last_run_at: Time.zone.now, checksum: sum)
  end
end
