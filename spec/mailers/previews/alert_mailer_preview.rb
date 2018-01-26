class AlertMailerPreview < ActionMailer::Preview
  def user_search_alert
    AlertMailer.user_alert(Alert::Search.first)
  end

  def user_bill_alert
    AlertMailer.user_alert(Alert::Bill.first)
  end
end
