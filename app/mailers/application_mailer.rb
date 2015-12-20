class ApplicationMailer < ActionMailer::Base
    default from: "noreply@rails-cook.localhost"
    layout 'mailer'
end
