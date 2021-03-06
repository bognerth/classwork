class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create 
		@user = User.new(params[:user])
		if @user.save
			session[:user_id] = @user.id
			Student.create(user_id: @user.id ,group_id: params[:group_id])  
			current = CurrentSession.create
			current.make(@user.id)
			session[:current_id] = current.id
			redirect_to test_students_url, notice: "Thank you for signin up!"
		else
			render "new"
		end
	end
	def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    @student = Student.find_by_user_id(@user.id)
    @student.update_attribute(:group_id, params[:group_id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end
	def index
		@users = User.all
	end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_url, :notice => "#{user.email} geloescht."
  end
end
