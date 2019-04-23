class Question < ApplicationRecord
  include Attachment
  include RatingScore

  has_many :answers, dependent: :destroy
  has_one :badge, dependent: :destroy

  belongs_to  :user

  accepts_nested_attributes_for :badge, reject_if: :all_blank

  validates :title, :body, presence: true
end
