class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_one :badge
  has_many :links, dependent: :destroy, as: :linkable

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

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
