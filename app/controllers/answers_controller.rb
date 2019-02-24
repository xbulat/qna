class AnswersController < ApplicationController
  before_action :authenticate_user!

  expose :answer
  expose :question
  expose :answers, -> { Answer.where(question: answer.question) }

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
    if (answer_params.key?(:best) && current_user.author_of?(answer.question)) ||
        current_user.author_of?(answer)

      answer.update(answer_params)
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

  private

  def answer_params
    params.require(:answer).permit(:body, :best)
  end
end
