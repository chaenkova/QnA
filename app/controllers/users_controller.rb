class UsersController < ApplicationController
  authorize_resource
  def rewards
    @rewards = User.find(params[:id]).rewards
  end
end
