class ApplicationController < ActionController::Base
  respond_to :html, :js, :json, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: exception.message }
      format.js { render head: :forbidden, js: "window.location = '#{root_url}'" }
      format.json { render json: { error: exception.message }, status: :forbidden }
    end
  end

  check_authorization unless: :devise_controller?
end
