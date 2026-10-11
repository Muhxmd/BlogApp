class ApplicationController < ActionController::Base
  include Pagy::Method
  allow_browser versions: :modern
  stale_when_importmap_changes

  # ADD THESE LINES
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ category_ids: [] ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ category_ids: [] ])
  end
end
