class QuestionsController < ApplicationController
  include Votes

  before_action :authenticate_user!, except: [:index, :show]

  expose :questions, ->{ Question.all }
  expose :question, scope: ->{ Question.with_attached_files }
  expose :answer, -> { question.answers.new }

  def new
    question.links.build
    question.badge ||= Badge.new
  end

  def show
    answer.links.build
  end

  def create
    question.user = current_user

    if question.save
      redirect_to question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if current_user.author_of?(question)
      question.update(question_params)
    else
      render status: :forbidden
    end
  end

  def destroy
    if current_user.author_of?(question)
      question.destroy
      flash[:notice] = 'Your question has been deleted.'
    else
      flash[:notice] = 'You can not delete foreign question.'
    end

    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:title,
                                     :body,
                                     files: [],
                                     links_attributes: [:name, :url, :_destroy],
                                     badge_attributes: [:title, :image, :_destroy]
                                    )
  end
end
