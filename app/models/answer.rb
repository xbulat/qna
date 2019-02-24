class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  before_save :ensure_one_best_answer, on: :update

  default_scope { order(best: :desc) }
  validates :body, presence: true

  private
  def ensure_one_best_answer
    question.answers.where(best: true).update_all best: false
  end
end
