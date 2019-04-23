class Rating < ApplicationRecord
  belongs_to :linkable, polymorphic: true
  has_many :votes

  validates :score, numericality: true

  def likes
    votes.where(like: true).count
  end

  def dislikes
    votes.where(like: false).count
  end
end
