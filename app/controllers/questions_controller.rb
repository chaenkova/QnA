class QuestionsController < ApplicationController
  include Voted 
  before_action :authenticate_user!, except: [:index, :show]
  before_action :question, except: [:index]
  before_action :set_gon, only: [:show]
  after_action :publish_question, only: %i[create]
  before_action :subscription, only: %i[show update]

  authorize_resource
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
    @question.build_reward
  end

  def edit
    @question.links.new
    @question.reward.present? ? @question.reward : @question.build_reward
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
    @question.destroy
    redirect_to questions_path
  end

  def delete_file
    @question.delete_file(params[:file_id])
    redirect_to question_path(@question)
  end

  private

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question',
        locals: {
          question: @question,
          current_user: current_user
        }
      )
    )
  end

  def question
    @question ||= params[:id] ? Question.with_attached_files.find(params[:id]) : Question.new
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body, :id, files: [], links_attributes: %i[id name url _destroy], reward_attributes: %i[id title image _destroy])
  end

  def set_gon
    gon.question_id = @question.id
    gon.current_user_id = current_user&.id
  end

  def subscription
    @subscription = @question.subscriptions.find_by(user: current_user)
  end
end