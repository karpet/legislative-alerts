class Alert < ApplicationRecord
  self.inheritance_column = :alert_type

  enum status: { active: 'active', archived: 'archived' }

  belongs_to :user

  before_create :generate_uuid

  scope :search, -> { where(alert_type: 'Alert::Search') }
  scope :bill, -> { where(alert_type: 'Alert::Bill') }
  scope :recent, -> { order(created_at: 'desc') }
  scope :by_name, -> { order('LOWER(name)') }

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
  end

  def mark_as_sent
    update_columns(last_sent_at: Time.zone.now)
  end

  def os_checksum(os_payload)
    Digest::SHA256.hexdigest os_payload.to_json
  end

  def checksum_short
    (checksum || 'nocheck')[0..7]
  end

  private

  def update_as_run(sum)
    self.checksum = sum
    update_columns(last_run_at: Time.zone.now, checksum: sum)
  end
end
