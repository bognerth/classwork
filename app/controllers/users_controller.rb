class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create 
		@user = User.new(params[:user])
		if @user.save
			#session[:user_id] = @user.id
			Student.create(user_id: @user.id ,group_id: params[:group_id])  
			redirect_to root_url, notice: "Thank you for signin up!"
		else
			render "new"
		end
	end

	def index
		@users = User.all
	end
end
