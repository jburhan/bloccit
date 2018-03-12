class SessionsController < ApplicationController
  def new
  end

  def create
    # we use downcase to normalize the email address since the address stored in the database are stored as lowercase strings
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    destroy_session(current_user)
    flash[:notice] = "You've been signed out"
    redirect_to root_path
  end

end
