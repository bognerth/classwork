class UserMailer < ActionMailer::Base
  default from: "bognerth@gmail.com"

  def new_user
		@user = User.last
		mail(:to => "", :subject => I18n.t("bookings.neue_buchung"))
  end
end