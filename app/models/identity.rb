class Identity < ActiveRecord::Base
  belongs_to :user, required: false
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_for_oauth(auth)
    identity = find_by(provider: auth.provider, uid: auth.uid)
    identity = create(uid: auth.uid, provider: auth.provider) if identity.nil?
    if auth.credentials
      identity.accesstoken = auth.credentials.token
      identity.refreshtoken = auth.credentials.refresh_token
      identity.secrettoken = auth.credentials.secret
    end
    if auth.info
      identity.email = auth.info.email
      identity.image = auth.info.image
    end
    identity.save
    identity
  end
end
