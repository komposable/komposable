class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_FROM', 'from@example.com')
  layout 'mailer'
end
