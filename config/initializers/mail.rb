# ActionMailer::Base.smtp_settings = {
#     address: "smtp.googlemail.com",
#     port: 587,
#     domain: "service-b.org",
#     user_name: "info@service-b.org",
#     password: "******",
#     authentication: :plain,
#     enable_starttls_auto: true
# }
ActionMailer::Base.smtp_settings = {
    address: 'smtprelaypool.ispgateway.de',
    port: 465,
    domain: 'ist-ur.org',
    user_name: ENV['MAIL_USER'], # Rails.application.secrets.mail_user,
    password: ENV['MAIL_PW'], # Rails.application.secrets.mail_pw,
    authentication: :login,
    enable_starttls_auto: true
}
