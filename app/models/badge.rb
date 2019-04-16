class Badge < ApplicationRecord
  belongs_to  :question, dependent: :destroy, touch: true
  belongs_to  :answer, optional: true
  belongs_to  :user, optional: true

  has_one_attached :image, dependent: :destroy
  validates :title, presence: true
end
