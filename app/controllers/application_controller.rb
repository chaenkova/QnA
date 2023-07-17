class ApplicationController < ActionController::Base
  respond_to :html, :js, if: :devise_controller?

end
