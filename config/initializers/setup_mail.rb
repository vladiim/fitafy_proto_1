ActionMailer::Base.smtp_settings = {
  address:                      "smtp.gmail.com",
  port:                         587,
  user_name:                    "fitafy.test",
  domain:                       "localhost.localdomain",
  password:                     "Gma1lF0rT3st",
  authentication:               "plain",
  enable_starttls_auto:         true
}