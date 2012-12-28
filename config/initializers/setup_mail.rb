ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "g16-hh.de",
  :user_name            => "g16bogner",
  :password             => "dagamaria",
  :authentication       => "plain",
  :enable_starttls_auto => true
}