class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_many_attached :files
  
  default_scope { order(best: :desc) }
  validates :body, presence: true

  def make_best
    transaction do
      question.answers.where(best: true).first&.update!(best: false)
      update!(best: true)
    end
  end
end
