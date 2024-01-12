# frozen_string_literal: true
class AnswersController < ApplicationController
  include Voted

  before_action :authenticate_user!
  before_action :find_question, only: %i[create publish_answer]
  before_action :find_answer, only: %i[destroy update mark_as_best delete_file]
  after_action :publish_answer, only: :create
  def new
    @answer = Answer.new
    render 'questions/show'
  end

  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
    render layout: false
  end

  def publish_answer
    return if @answer.errors.any?

    ActionCable.server.broadcast(
        "question/#{@question.id}/answers",
        hash_for_cable
    )
  end
  def hash_for_cable
    hash = {
      answer: @answer,
      rating: @answer.rating,
      links: @answer.links,
      question_author: @question.user,
      files: []
    }
    if @answer.files.attached?
      @answer.files.each_with_index do |file, i|
        hash[:files][i] = {
          id: file.id,
          name: file.filename.to_s,
          url: url_for(file)
        }
      end
    end
    hash
  end
  def update
    @answer.update(answer_params.merge(user: current_user))
    render layout: false
  end

  def destroy
    if current_user.author?(@answer)
      @answer.destroy
      @question = @answer.question
      render layout: false
    else
      redirect_to questions_path
    end
  end

  def mark_as_best
    return unless current_user.author?(@answer.question)

    @answer.mark
    @question = @answer.question
    render layout: false

  end

  def delete_file
    @answer.delete_file(params[:file_id])
    redirect_to question_path(@answer.question)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: %i[id name url _destroy])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end
end