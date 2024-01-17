class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone])
  end

  def after_sign_in_path_for(resource)
    return root_path if resource.is_a?(User)

    super
  end

  def after_sign_out_path_for(resource_scope)
    return logged_out_path if resource_scope == :user

    super
  end
end
