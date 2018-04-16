class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.authenticate(params[:session][:email], params[:session][:password])
  	if user.nil?
  		flash[:error] = "couldn't find a user with those credentials"
      redirect_to new_session_path
  	else
  		sign_in user
  		redirect_to user
  	end
  end

  def destroy
  	sign_out 
  	redirect_to signin_path
  end

end