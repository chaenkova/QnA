class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :question, except: [:index]
  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
  end

  def new

  end

  def edit

  end

  def create
    question.update(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created'
    else
      render :new, notice: 'Your question not created'
    end
  end

  def update
    if question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy if current_user.author?(@question)
    redirect_to questions_path
  end

  private

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body, :id)
  end
end