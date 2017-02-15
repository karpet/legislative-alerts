class ApplicationMailer < ActionMailer::Base
  default from: (ENV['FROM_ADDRESS'] || 'alerts@legalerts.us')
  layout 'mailer'
end
