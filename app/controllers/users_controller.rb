class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end
  	def new
  		@user = User.new
  	end
  	def create
  		@user = User.new(user_params)
  		if @user.save
  			flash[:success] = "Welcome to the App Bwaa!"
  			redirect_to @user #basically same thing as user_url(@user)
  		else
  			render 'new'
  		end
  	end

  	private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
