module Voted
  extend ActiveSupport::Concern

  included do
    before_action :find_votable, only: %i[vote_plus vote_minus cancel]
  end

  def vote_plus
    if current_user.author?(@votable)
      add_errors
      render_json_with_errors
    else
      @votable.vote_plus(current_user)

      render_json_with_rating
    end
  end

  def vote_minus
    if current_user.author?(@votable)
      add_errors
      render_json_with_errors
    else
      @votable.vote_minus(current_user)

      render_json_with_rating
    end
  end

  def cancel
    if current_user.author?(@votable)
      add_errors
      render_json_with_errors
    else
      @votable.cancel(current_user)

      render_json_with_rating
    end
  end

  private

  def add_errors
    @votable.errors.add(model_klass.name, "can't vote")
  end

  def render_json_with_rating
    render json: {
      resource_id: @votable.id,
      resource_name: controller_name,
      voted_before: @votable.voted_before?(current_user),
      rating: @votable.rating,
      status: :accepted
    }
  end

  def render_json_with_errors
    render json: {
      error: @votable.errors.full_messages,
      status: :unprocessable_entity
    }
  end

  def model_klass
    controller_name.classify.constantize
  end

  def find_votable
    @votable = model_klass.find(params[:id])
  end
end