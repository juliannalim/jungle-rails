class SessionsController < ApplicationController

  def create
    # If the user exists AND the password entered is correct.
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
    flash[:notice] = 'Failed to log in'
    redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

# this might help with the messaging
# https://stackoverflow.com/questions/43506832/rails-5-displaying-error-messages
end