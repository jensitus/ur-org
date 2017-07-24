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
    port: 587,
    domain: 'ist-ur.org',
    user_name: 'info@ist-ur.org',
    password: Rails.application.secrets.mail_pw,
    authentication: :plain,
    enable_starttls_auto: true
}
