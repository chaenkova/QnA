class ApplicationController < ActionController::Base
  respond_to :html, :js, :json, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  check_authorization unless: :devise_controller?
end
