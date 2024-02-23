class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def create
    @question = Question.find(params[:question_id])
    @subscription = @question.subscriptions.create(user: current_user)
    render layout: false
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    render layout: false
  end
end