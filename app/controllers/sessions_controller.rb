class SessionsController < ApplicationController
  def new
  end
  def create
  @user = User.find_by(email: params[:session][:email].downcase)
  if @user && @user.authenticate(params[:session][:password])
    # Create an error message and re-render the signin form.
    log_in @user
    params[:session][:remember_me] == '1'? remember(@user): forget(@user)
    redirect_back_or @user

   else
     flash.now[:danger] = "Invalid email/password combination."
     render 'new'
    # Sign the user in and redirect to the user's show page.
    #
  end
 end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
