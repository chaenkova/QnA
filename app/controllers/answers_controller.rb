class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[create]
  before_action :find_answer, only: %i[destroy update mark_as_best delete_file]
  def new
    @answer = Answer.new
    render 'questions/show'
  end
  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
    render layout: false
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
    if current_user.author?(@answer.question)
      @answer.mark
      @question = @answer.question
      render layout: false
    end
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
