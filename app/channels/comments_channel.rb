class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "question/#{params[:question_id]}/comments"
  end

end