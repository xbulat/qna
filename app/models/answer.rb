class Answer < ApplicationRecord
  include Attachment
  include RatingScore

  belongs_to :question
  belongs_to :user
  has_one :badge

  default_scope { order(best: :desc) }
  validates :body, presence: true

  def make_best
    transaction do
      question.answers.where(best: true).first&.update!(best: false)
      question.badge.update!(user: user, answer: self) if question.badge.present?
      update!(best: true)
    end
  end
end
