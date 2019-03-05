class AnswersController < ApplicationController
  before_action :authenticate_user!

  expose :answer
  expose :question
  expose :answers, from: :question

  def create
    @answer = question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @answer.question, notice: 'Your answer successfully created.'
    else
      render 'questions/show'
    end
  end

  def update
    if current_user.author_of?(answer)
      answer.update(answer_params)
    else
      render status: :forbidden
    end
  end

  def destroy
    if current_user.author_of?(answer)
      answer.destroy
      flash_msg = 'Your answer successfully deleted.'
    else
      flash_msg = 'You can not delete foreign answer.'
    end

    redirect_to answer.question, notice: flash_msg
  end

  def best
    if current_user.author_of?(answer.question)
      answer.make_best
      @answers = answer.question.answers
    else
      render status: :forbidden
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [])
  end
end
