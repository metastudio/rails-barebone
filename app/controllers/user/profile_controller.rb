# frozen_string_literal: true

class User::ProfileController < User::BaseController
  def index; end

  def update
    if current_user.update(user_params)
      redirect_to user_profile_path, notice: 'Your account has been updated successfully.'
    else
      render :index
    end
  end

  def update_email
    if current_user.update_with_password(user_email_params)
      redirect_to user_profile_path,
                  notice: 'Your email has been updated successfully.'
    else
      render :index
    end
  end

  def update_password
    if current_user.update_with_password(user_password_params)
      bypass_sign_in current_user
      respond_to do |format|
        format.html { redirect_to user_profile_path, notice: 'Your password has been updated successfully.' }
        format.turbo_stream { flash.now[:notice] = "Your password has been updated successfully." }
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def user_email_params
    params.require(:user).permit(:email, :current_password)
  end
end
