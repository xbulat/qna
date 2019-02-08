class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  expose :question
  expose :answers, from: :question
  expose :answer

  def create
    @answer = question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @answer.question, notice: 'Your answer successfully created.'
    else
      render 'questions/show'
    end
  end

  def destroy
    if answer.user == current_user
      answer.destroy
      flash[:notice] = 'Your answer successfully deleted.'
    else
      flash[:notice] = 'You can not delete foreign answer.'
    end

    redirect_to answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
