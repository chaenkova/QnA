class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[create]
  before_action :find_answer, only: %i[destroy update]
  def new
    @answer = Answer.new
    render 'questions/show'
  end
  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
    render layout: false
  end

  def update
    p @answer
    @answer.update(answer_params.merge(user: current_user))
    #render layout: false
  end

  def destroy
    @answer.destroy if current_user.author?(@answer)
    redirect_to question_path(@answer.question)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
