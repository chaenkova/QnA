class UsersController < ApplicationController
  def rewards
    @rewards = User.find(params[:id]).rewards
  end
end
