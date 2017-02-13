class AlertMailer < ApplicationMailer
  def from_address
    ENV['FROM_ADDRESS'] || 'legalerts@legalerts.us'
  end

  def user_alert(alert)
    @alert = alert
    mail(
      to: alert.user.email,
      subject: "[LegAlerts] #{alert.name}"
    )
  end
end
