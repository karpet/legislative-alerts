class Alert < ApplicationRecord
  belongs_to :user

  before_create :generate_uuid

  def to_param
    uuid
  end

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def pretty_query
    query
  end
end
