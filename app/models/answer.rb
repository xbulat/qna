class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  default_scope { order(best: :desc) }
  validates :body, presence: true

  def make_best
    transaction do
      question.answers.where(best: true).update(best: false)
      update(best: true)
    end
  end
end
