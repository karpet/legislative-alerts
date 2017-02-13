class AlertChecker
  attr_accessor :user, :when

  def initialize(user:, when: Time.zone.now)
    self.user = user
    self.when = when
  end

  def run
    alerts.each do |alert|
      AlertMailer.user_alert(alert).deliver_later
    end
  end

  def alerts
    to_send = []
    Alert.where(user: user).where('last_run_at < ?', when).each do |alert|
      to_send << alert if alert.check
    end
    to_send
  end
end
