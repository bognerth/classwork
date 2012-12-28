class UserMailer < ActionMailer::Base
  default from: "g16bogner@gmail.com"

  def registration_confirmation(user)
		mail(:to => user.email, :subject => "Registrierung classwork.g16-hh.de")
  end
end