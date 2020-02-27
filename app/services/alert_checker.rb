class AlertChecker
  attr_accessor :user, :run_at

  def initialize(user:, run_at: Time.zone.now)
    self.user = user
    self.run_at = run_at
  end

  def run
    alerts.each do |alert|
      m = AlertMailer.user_alert(alert).deliver_later
      Delayed::Worker.logger.debug('deliver_later: ' + m.serialize.to_s)
      alert.mark_as_sent
    end
  end

  def alerts
    to_send = []
    Alert.active.where(user: user).where('last_run_at < ?', run_at).each do |alert|
      to_send << alert if alert.check
      sleep 5 # avoid rate limiting
    end
    to_send
  end
end
