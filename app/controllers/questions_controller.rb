class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :question, except: [:index]
  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
    @answer.links.new
  end

  def new
    @question = Question.new
    @question.links.new
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
    question.update(question_params.merge(user: current_user))
    render layout: false
  end

  def destroy
    @question.destroy if current_user.author?(@question)
    redirect_to questions_path
  end

  def delete_file
    if current_user.author?(@question)
      @question.delete_file(params[:file_id])
      redirect_to question_path(@question)
    end
  end

  private

  def question
    @question ||= params[:id] ? Question.with_attached_files.find(params[:id]) : Question.new
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body, :id, files: [], links_attributes: %i[id name url _destroy])
  end
end