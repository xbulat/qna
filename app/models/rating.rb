class Rating < ApplicationRecord
  belongs_to :linkable, polymorphic: true
  belongs_to :user

  validates :score, inclusion: { in: [-1, 1] }
end
