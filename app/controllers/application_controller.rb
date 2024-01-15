class ApplicationController < ActionController::Base
  respond_to :html, :js, :json, if: :devise_controller?

end
