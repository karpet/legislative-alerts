class AlertMailer < ApplicationMailer
  def user_alert(alert)
    @alert = alert
    mail(
      to: alert.user.email,
      subject: "[LegAlerts] #{alert.name}"
    )
  end
end
