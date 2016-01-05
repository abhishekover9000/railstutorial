class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase) # Get user by password
  	if user && user.authenticate(params[:session][:password]) #if the user exists and is logged in
  		
  		log_in user # Log User In
  		if params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_to user # automatically redirects to user_url(user)
  	else
  		flash.now[:danger] = 'Invalid email/password combo' #Make Error Message
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
