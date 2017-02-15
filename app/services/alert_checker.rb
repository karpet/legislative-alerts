class AlertChecker
  attr_accessor :user, :run_at

  def initialize(user:, run_at: Time.zone.now)
    self.user = user
    self.run_at = run_at
  end

  def run
    alerts.each do |alert|
      AlertMailer.user_alert(alert).deliver_later
      alert.mark_as_sent
    end
  end

  def alerts
    to_send = []
    Alert.where(user: user).where('last_run_at < ?', run_at).each do |alert|
      to_send << alert if alert.check
    end
    to_send
  end
end
