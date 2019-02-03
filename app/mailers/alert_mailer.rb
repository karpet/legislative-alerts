class AlertMailer < ApplicationMailer
  def user_alert(alert)
    @alert = alert
    mail(
      to: alert.user.email,
      subject: "[LegAlerts] #{alert.name}"
    )
  end

  def admin_alert(stats)
    @stats = stats
    mail(
      to: 'admin@legalerts.us',
      subject: '[LegAlerts] Daily report'
    )
  end
end
