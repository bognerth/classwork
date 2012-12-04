class SessionsController < ApplicationController
  def new
  end

  def create
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			current = CurrentSession.create
			current.make(user.id)
			session[:current_id] = current.id
			#raise current.to_yaml
			if current.group_id == 1
				redirect_to tests_url, notice: "Logged in!"
			else
				redirect_to test_students_url, notice: "Logged in!"
			end
		else		
			flash.now.alert = "Email or password is invalid."
			render "new"
		end
	end

	def destroy
		session[:current_id] = nil
		redirect_to root_url,notice:"Logged out!"
	end

end
