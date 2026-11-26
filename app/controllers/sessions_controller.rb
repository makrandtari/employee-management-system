class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    email = params[:email].to_s.strip.downcase
    user = User.find_by(email: email)

    if user && user.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id

      if user.role == "admin"
        redirect_to employee_index_path,
                    notice: "Admin Login Successful"
      elsif user.employee_id.present?
        redirect_to employee_path(user.employee_id),
                    notice: "Employee Login Successful"
      else
        reset_session
        redirect_to login_path,
                    alert: "Employee profile not linked"
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Logged out successfully!"
  end
end
