class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable
  before_action :set_gon, only: :create
  after_action :publish_comment, only: :create

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    render layout: false
  end

  private

  def set_commentable
    @resource, @resource_id = request.path.split('/')[1, 2]
    @resource = @resource.singularize
    @commentable = @resource.classify.constantize.find(@resource_id)
  end

  def publish_comment
    return if @comment.errors.any?

    question_id = @commentable.instance_of?(Question) ? @commentable.id : @commentable.question_id
    ActionCable.server.broadcast(
      "question/#{question_id}/comments",
        comment: @comment.as_json,
        user: @comment.user.as_json

    )
  end

  def set_gon
    gon.resource_klass = @commentable.class
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end