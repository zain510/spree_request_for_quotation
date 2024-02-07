class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@spree.com"
  layout "mailer"
end
