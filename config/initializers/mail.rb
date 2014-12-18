ActionMailer::Base.smtp_settings = {
    address: "smtp.googlemail.com",
    port: 587,
    domain: "service-b.org",
    user_name: "info@service-b.org",
    password: "zenturio",
    authentication: :plain,
    enable_starttls_auto: true
}