class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: %i[first_name last_name phone])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[first_name last_name phone])
  end

  private

  def after_accept_path_for(_resource)
    root_path
  end
end
